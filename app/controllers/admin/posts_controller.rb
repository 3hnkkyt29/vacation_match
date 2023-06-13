class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.includes(:user).where(users:{is_deleted: false})
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :tag, :keyword, :image)
    end
end
