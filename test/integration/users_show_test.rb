require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  # 本棚画面に対するテスト
  test "shelf display" do
    get user_path(@non_admin)
    assert_template 'users/show'
    assert_select 'p', text: "#{@non_admin.name}さんの10冊"
    assert_match @non_admin.comments, response.body
    assert_select 'div.comments'
  end

  # 本の削除テスト
  test "delete book link" do
    @non_admin.books.build()
    books = Book.where(user_id: @non_admin.id)
    books.each do |book|
      assert_select 'a[href=?]', book_path(book), text: '登録解除'
      assert_difference 'Book.count', -1 do
        delete book_path(book)
      end
    end
  end

  # 削除リンク(ユーザー)とユーザー削除に対する統合テスト
  test "admin and delete links" do
    log_in_as(@admin)
    get user_path(@non_admin)
    assert_template 'users/show'
    unless @non_admin == @admin
      assert_select 'a[href=?]', user_path(@non_admin), text: 'delete'
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get user_path(@admin)
    assert_select 'a', text: 'delete', count: 0
    get user_path(@non_admin)
    assert_select 'a', text: 'delete', count: 0
  end
end
