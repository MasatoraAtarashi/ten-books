require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:archer)
    @other = users(:michael)
    @like = Like.new(user_id: users(:michael).id,
                     liked_id: users(:archer).id)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "should require a user_id" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "should require a liked_id" do
    @like.liked_id = nil
    assert_not @like.valid?
  end

  # has_many: :destroyのテスト
  test "associated likes should be destroyed" do
    @user.like(@other)
    assert_difference 'Like.count', -1 do
      @user.destroy
    end
  end
end
