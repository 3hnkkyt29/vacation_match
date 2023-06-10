class Public::HomesController < ApplicationController
  def top
    @post = Post.order(created_at: :desc).limit(5)
  end

  def about
  end
end
