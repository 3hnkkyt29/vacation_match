class Public::SearchesController < ApplicationController
  # before_action :authenticate_user!

  def search
    @content = params[:content].split(/[[:blank:]]+/)
    @records = Post.none
      @content.each_with_index do |content, i|
        @records = Post.search_for(content) if i == 0
        @records = @records.merge(@records.search_for(content))
      end
  end

end
