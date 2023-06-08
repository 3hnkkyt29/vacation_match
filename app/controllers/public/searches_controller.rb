class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    @records = Post.search_for(@content)
  end

end
