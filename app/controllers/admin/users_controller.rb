class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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
