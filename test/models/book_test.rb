require 'test_helper'

class BookTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @book= Book.new(title: "money ball", authors: "michel", published_date: "2015",
                    image_link: "fjwioejf", user_id: @user.id)
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "user id should be present" do
    @book.user_id = nil
    assert_not @book.valid?
  end
end
