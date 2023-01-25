class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_comment = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post_comment.id
    if comment.save
      # 通知も同時に作成
      notification = current_user.active_notifications.new(
        visited_id: @post_comment.user_id,
        post_id: comment.post_id,
        action: 'comment',
        comment_id: comment.id
        )
      if notification.visitor_id == notification.visited_id
          notification.checked = true
      end
      notification.save if notification.valid?
      redirect_to post_path(@post_comment),notice: '投稿に成功しました'
    else
      redirect_to post_path(@post_comment), alert: 'コメントは1文字以上300文字以内で入力してください'
    end
  end

  def destroy
    @post_comment = Post.find(params[:post_id])
    # 通知を削除する
    Notification.find_by(visitor_id: current_user.id,visited_id: @post_comment.user_id,post_id: @post_comment.id,action: 'comment',comment_id: params[:id]).destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id]), notice: '投稿を削除しました'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
