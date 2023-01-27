class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    if @comment.save
      # 通知も同時に作成
      notification = current_user.active_notifications.new(
        visited_id: @post.user_id,
        post_id: @comment.post_id,
        action: 'comment',
        comment_id: @comment.id
        )
      if notification.visitor_id == notification.visited_id
          notification.checked = true
      end
      notification.save if notification.valid?
    else
      render :error
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id]) #エラーメッセージが表示されている場合、エラーメッセージをクリアにする
    # 通知を削除する
    Notification.find_by(visitor_id: current_user.id,visited_id: @post.user_id,post_id: @post.id,action: 'comment',comment_id: params[:id]).destroy
    PostComment.find(params[:id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
