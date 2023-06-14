class Public::SearchesController < ApplicationController

  def search
    # キーワードと都道府県で検索した場合
    if (!params['content'].empty? && params['tag'] != '---') then
      @content = params[:content].split(/[[:blank:]]+/)
      @records = Post.none
      @content.each_with_index do |content, i|
        @records = Post.search_for(content) if i == 0
        @records = @records.merge(@records.search_for(content))
      end
      @records = @records.where(tag: params['tag'])
      @records = Kaminari.paginate_array(@records).page(params[:page]).per(12)
    # キーワードのみで検索した場合
    elsif !params['content'].empty?
      @content = params[:content].split(/[[:blank:]]+/)
      @records = Post.none
      @content.each_with_index do |content, i|
        @records = Post.search_for(content) if i == 0
        @records = @records.merge(@records.search_for(content)).page(params[:page]).per(12)
      end
    # 都道府県のみで検索した場合
    elsif !params['tag'] != '---'
      @records = Post.none
      @records = Post.where(tag: params['tag'])
      @records = Kaminari.paginate_array(@records).page(params[:page]).per(12)
    end
  end

end
