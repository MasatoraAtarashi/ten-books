require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @book = books(:moneyball)
  end

  test "should get search" do
    get "/books/search/moneyball"
    assert_response :success
  end

  # Booksコントローラの認可テスト
  # logged_in_user
  test "should redirect create when not logged in" do
    assert_no_difference 'Book.count' do
      post books_path, params: { }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Book.count' do
      delete book_path(@book)
    end
    assert_redirected_to login_url
  end

  # correct_user
  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@other_user)
    book = books(:snowball)
    assert_not book.nil?
    delete book_path(book)
    assert flash.empty?
    assert_redirected_to root_url
  end
end
