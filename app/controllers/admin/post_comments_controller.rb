class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
   # 不適切なコメントは管理者側で削除
   @post = Post.find(params[:post_id])
   @comment = PostComment.find(params[:id])
   # 通知を削除する
    Notification.find_by(visitor_id: @comment.user_id,visited_id: @post.user_id,post_id: @post.id,action: 'comment',comment_id: @comment.id).destroy
    PostComment.find(params[:id]).destroy
  end
end
