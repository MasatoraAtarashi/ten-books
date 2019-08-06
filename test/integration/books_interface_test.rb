require 'test_helper'

class BooksInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "book interface" do
    log_in_as(@user)
    get root_path
    assert_select 'input#search-field'
    keyword = 'moneyball'
    isbn = '1784274367991'
    # 本を検索
    # 空白とか/とかのエスケープ処理はjqueryでやってるからどうやってテストするかわからない
    get "/books/search/#{keyword}"
    assert_template 'books/search'
    assert_select 'li.collection-item'
    assert_match keyword, response.body
    assert_select 'button', '本棚に追加'
    # 本を登録(無効な送信は送りようがない)
    assert_difference 'Book.count', 1 do
      post books_path, params: { title: keyword, isbn: isbn }
    end
    follow_redirect!
    assert_template 'users/show'
    # 同じ本を二度登録
    assert_difference 'Book.count', 0 do
      post books_path, params: { title: keyword, isbn: isbn, id: keyword }
    end
    assert_not flash.empty?
    follow_redirect!
    assert_match keyword, response.body
  end
end
