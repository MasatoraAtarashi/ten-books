require 'test_helper'

class UsersLikeTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    log_in_as(@user)
  end

  # likesページのテスト
  test "liking page" do
    get likes_user_path(@user)
    assert_not @user.likes.empty?
    assert_select 'li.collection-item', count: @user.likes.count
    @user.likes.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  # like/unlikeボタンをテストする
  test "should like a user the standard way" do
    assert_difference '@user.likes.count', 1 do
      post likes_path, params: { liked_id: @other.id }
    end
  end

  test "should like a user with Ajax" do
    assert_difference '@user.likes.count', 1 do
      post likes_path, xhr: true, params: { liked_id: @other.id }
    end
  end

  test "should unlike a user the standard way" do
    @user.like(@other)
    like = @user.active_relationships.find_by(liked_id: @other.id)
    assert_difference '@user.likes.count', -1 do
      delete like_path(like)
    end
  end

  test "should unlike a user with Ajax" do
    @user.like(@other)
    like = @user.active_relationships.find_by(liked_id: @other.id)
    assert_difference '@user.likes.count', -1 do
      delete like_path(like), xhr: true
    end
  end
end
