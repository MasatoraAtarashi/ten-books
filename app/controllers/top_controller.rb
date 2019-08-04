class TopController < ApplicationController
  def index
    @rank_books = Book.rank_books
    @rank_shelves = User.rank_shelves
  end
end
