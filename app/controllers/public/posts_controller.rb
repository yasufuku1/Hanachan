class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]
  before_action :ensure_guest_user, only: [:new]
  before_action :login_check_user,only: [:show]

  def search
    @search = Post.search(params[:word])
    if @search == nil
      redirect_to posts_path,alert: "検索条件が空です"
    else
    @posts = @search.order(created_at: :desc).page(params[:page]).per(8)
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
    redirect_to post_path(@post),notice: "投稿が完了しました "
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post),notice: "投稿を編集しました "
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path,notice: "投稿を削除しました "
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path, alert: "不正なアクセスです"
    end
  end

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to posts_path, alert: "ゲストユーザは閲覧のみのご利用となります。サービスのご利用にはユーザ登録が必要になります"
    end
  end

  def login_check_user
    unless user_signed_in?
      redirect_to posts_path, alert: "これより先のサービスはログインが必要となります"
    end
  end
end
