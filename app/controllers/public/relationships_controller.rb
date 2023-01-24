class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    user = Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id])
    user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    Notification.find_by(visitor_id: current_user.id, visited_id: params[:user_id],action: 'follow').destroy
    redirect_to request.referer
  end
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(8)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(8)
  end
end
