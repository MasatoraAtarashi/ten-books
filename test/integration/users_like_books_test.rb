require 'test_helper'

class UsersLikeBooksTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "index including pagination" do
    log_in_as(@user)
    get likes_user_path(@user)
    assert_template 'users/likes'
    Kaminari.paginate_array(@user.likes).page(1).per(10).each do |user|
      assert_select 'a[href=?]', user_path(user.id), text: user.name
    end
  end
end
