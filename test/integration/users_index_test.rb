require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  test "index including pagination" do
    get users_path
    assert_template 'users/index'
    assert_select 'ul.pagination'
    Kaminari.paginate_array(User.rank_shelves_all).page(1).per(10).each do |user|
      assert_select 'a[href=?]', user_path(user.id), text: user.name
    end
  end
end
