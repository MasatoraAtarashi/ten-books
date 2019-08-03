class TopController < ApplicationController
  def index
    @rank_books = Book.rank_books
  end
end
