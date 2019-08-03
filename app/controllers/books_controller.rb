class BooksController < ApplicationController
   before_action :logged_in_user
   before_action :correct_user,   only: :destroy

  # 検索ボックスの内容をもとに書籍を検索して表示する
  def show
    @keyword = params[:id]
    @books = GoogleBooks.search(@keyword, {:count => 30}).to_a.paginate(page: params[:page], :per_page => 10)
  end

  # 本棚に本データを追加する(十冊を選ぶ)
  def create
    if Book.where(user_id: current_user.id).count <= 9
      @book = current_user.books.build(books_params)
      if @book.save
        flash[:success] = "本を登録しました！"
        redirect_to current_user
      else
        flash[:danger] = "登録に失敗しました"
        redirect_to("/books/#{params[:id]}")
      end
    else
      flash[:danger] = "これ以上登録できません"
      redirect_to("/books/#{params[:id]}")
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "登録を解除しました"
    redirect_to request.referrer || root_url
  end

  private
    def books_params
      params.permit(:image_link, :title, :authors, :published_date, :isbn, :comments)
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to root_url if @book.nil?
    end
end
