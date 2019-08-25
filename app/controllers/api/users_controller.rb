class Api::UsersController < ApplicationController
  def index
    @users = User.all
    @users = @users.map do |user|
      {
          id: user.id,
          name: user.name,
          email: user.email,
          comments: user.comments,
          picture: user.picture,
          job: user.job,
      }
    end
    render json: @users
  end

  def show
    user = User.find(params[:id])
    books = Book.where(user_id: user.id)
    user = {
      id: user.id,
        name: user.name,
        email: user.email,
        comments: user.comments,
        picture: user.picture,
        job: user.job,
    }
    books = books.map do |book|
      {
        id: book.id,
        title: book.title,
        authors: book.authors,
        published_date: book.published_date,
        image_link: book.image_link,
        user_id: book.user_id,
        isbn: book.isbn,
        info_link: book.info_link,
      }
    end
    render json: { user: user, books: books }
  end
end
