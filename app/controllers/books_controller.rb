class BooksController < ApplicationController

  # 検索ボックスの内容をもとに書籍を検索して表示する
  def show
    @keyword = params[:keyword]
    render 'show'
  end

  # 本データをデータベースに追加する
  def create
  end
end
