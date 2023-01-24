class Public::FavoritesController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :authenticate_user!


  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    favorite.create_notification_like!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    Notification.find_by(visitor_id: current_user.id,visited_id: @post.user_id,post_id: @post.id,action: 'like').destroy
  end

  def index
    post_ids = Favorite.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.where(id: post_ids).order(created_at: :desc).page(params[:page]).per(8)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
