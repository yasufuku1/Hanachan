class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit,:update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :ensure_active_user, only: [:show]

  def show
    # unsubscribeでリロードされた時の対策
    if params[:id] == "unsubscribe"
      redirect_to root_path, notice: "リロードされた為トップページに戻りました"
      return
    end

    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(8)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice: "プロフィールを編集しました"
    else
    render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path,notice: "退会が完了しました"
  end

  def search
    search_users = User.where.not(name: 'guestuser').search(params[:user_search])
    if search_users == nil
      @users = search_users
    else
      @users = search_users.page(params[:page]).per(8)
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "不正なアクセスです"
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), alert: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end

  def ensure_active_user
    @user = User.find_by(id: params[:id])
    if @user.is_active == false
      redirect_to root_path, alert: "退会済みのユーザです"
    end
  end
end
