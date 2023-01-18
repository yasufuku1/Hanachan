class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_comment = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post_comment.id
    if comment.save
#      comment.create_notification_comment!(current_user, comment.id)
      redirect_to post_path(@post_comment),notice: '投稿に成功しました'
    else
      redirect_to post_path(@post_comment), alert: 'コメントは4文字以上300文字以内で入力してください'
    end

  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id]), notice: '投稿を削除しました'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
