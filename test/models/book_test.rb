require 'test_helper'

class BookTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @book= Book.new(title: "money ball", author: "michel", published_date: "2015",
                    image_url: "fjwioejf", user_id: @user.id, comments: "nice")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "user id should be present" do
    @book.user_id = nil
    assert_not @book.valid?
  end
end
