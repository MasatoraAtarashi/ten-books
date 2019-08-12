class BookCommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def update
    @book = Book.find(params[:id])
    if @comment = BookComment.find_by(user_id: current_user.id, book_id: @book.id)
      if comment_params[:content].empty?
        p comment_params[:content]
        @comment.destroy
        redirect_to @book
      else
        if @comment.update_attributes(comment_params)
          @comments = BookComment.where(book_id: @book.id)
          flash[:success] = "コメントが更新されました"
          redirect_to @book
        else
          @comments = BookComment.where(book_id: @book.id)
          render 'books/show'
        end
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

  private
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(Book.find(params[:id]).user_id)
      redirect_to(root_url) unless current_user?(@user)
    end

    def comment_params
      params[:user_id] = current_user.id
      params.permit(:user_id, :content)
    end
end
