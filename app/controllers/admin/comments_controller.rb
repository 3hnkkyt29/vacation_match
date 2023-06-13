class Admin::CommentsController < ApplicationController
before_action :authenticate_admin!

  def index
    @comments = Comment.includes(:user).where(users:{is_deleted: false}).page(params[:page]).per(15)
  end

  def destroy
    comment = Comment.find(params[:id])
    post_id = comment.post_id
    comment.destroy
    redirect_to admin_post_path(post_id)
  end
end
