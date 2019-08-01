require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  # 削除リンクとユーザー削除に対する統合テスト
  test "admin and delete links" do
    log_in_as(@admin)
    get user_path(@non_admin)
    assert_template 'users/show'
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get user_path(@admin)
    assert_select 'a', text: 'delete', count: 0
  end
end
