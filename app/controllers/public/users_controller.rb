class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :resign_guest_user, only: [:confirm]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated your profile successfully!"
      redirect_to user_path
    else
      flash[:notice] = "Failed to update."
      render :edit
    end
  end

  def confirm
  end

  def resign
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    # フラッシュメッセージ入れる？？
    redirect_to root_path
  end

  def favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guest"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def resign_guest_user
     @user = User.find(params[:id])
    if @user.name == "guest"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーは退会できません。'
    end
  end
end
