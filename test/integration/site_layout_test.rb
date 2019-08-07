require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'top/index'
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", '/#about'
    @rank_books = Book.rank_books
    @rank_books.each do |book|
      assert_select 'a[href=?]', "/books/#{Book.find_by(title: book[0], info_link: book[2]).id}"
    end
    @rank_shelves = User.rank_shelves
    @rank_shelves.each do |shelf|
      assert_select 'a[href=?]', "/users/#{shelf.id}"
    end
  end
end
