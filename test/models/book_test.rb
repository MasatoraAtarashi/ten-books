require 'test_helper'

class BookTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @book = @user.books.build(title: "money ball", authors: "michel", published_date: "2015",
                    image_link: "fjwioejf", isbn: "9784274067938")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "user id should be present" do
    @book.user_id = nil
    assert_not @book.valid?
  end

  # isbn,title,user_idの複合uniqueness
  test "isbn-title-user_id combination should be unique" do
    duplicate_book = @user.books.build(title: @book.title, isbn: @book.isbn)
    @book.save
    assert_not duplicate_book.valid?
  end
end
