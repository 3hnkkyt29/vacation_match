class Admin::UsersController < ApplicationController
before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end
end
