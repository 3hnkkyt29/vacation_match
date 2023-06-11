class Admin::CommentsController < ApplicationController
before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def destroy
    comment = Comment.find(params[:id])
    post_id = comment.post_id
    comment.destroy
    redirect_to admin_post_path(post_id)
  end
end
