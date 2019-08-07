class BookCommentsController < ApplicationController

  def update
    @book = Book.find(params[:id])
    if @comment = BookComment.find_by(user_id: current_user.id, book_id: @book.id)
      if @comment.update_attributes(comment_params)
        @comments = BookComment.where(book_id: @book.id)
        flash[:success] = "コメントが更新されました"
        redirect_to @book
      else
        @comments = BookComment.where(book_id: @book.id)
        render 'books/show'
      end
    else
      @comment = @book.book_comments.new(comment_params)
      if @comment.save
        @comments = BookComment.where(book_id: @book.id)
        flash[:success] = "コメントが更新されました"
        redirect_to @book
      else
        @comments = BookComment.where(book_id: @book.id)
        render 'books/show'
      end
    end
  end

  def destroy
  end

  private
    def comment_params
      params[:user_id] = current_user.id
      params.permit(:user_id, :content)
    end
end
