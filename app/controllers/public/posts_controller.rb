class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have posted successfully!"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "Failed to post."
      render :new
    end
  end

  def index
    # 新着順
    if params[:latest]
      @posts = Post.includes(:user).where(users:{is_deleted: false}).page(params[:page]).per(12).latest
    # 古い順
    elsif params[:old]
      @posts = Post.includes(:user).where(users:{is_deleted: false}).page(params[:page]).per(12).old
    # いいねが多い順
    elsif params[:most_favorited]
      @posts = Post.includes(:user).where(users:{is_deleted: false}).most_favorited
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
    # コメントが多い順
    elsif params[:most_commented]
      @posts = Post.includes(:user).where(users:{is_deleted: false}).most_commented
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
    else
      @posts = Post.includes(:user).where(users:{is_deleted: false}).page(params[:page]).per(12).order(created_at: :desc)
    end
  end


  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "You have posted again successfully!"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "Failed to post."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :tag, :keyword, :image)
  end
end
