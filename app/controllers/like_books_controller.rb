require 'will_paginate/array'
class LikeBooksController < ApplicationController

  # 検索ボックスの内容をもとに書籍を検索して表示する
  def show
    @keyword = params[:id]
    @books = GoogleBooks.search(@keyword, {:count => 30}).to_a.paginate(page: params[:page], :per_page => 10)
  end

  # 本棚に本データを追加する(十冊を選ぶ)
  def create
    redirect_to root_url
  end

end
