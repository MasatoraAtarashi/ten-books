require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  # 編集の失敗に対するテスト
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { name:  "",
                                      email: "foo@invalid",
                                      password:              "foo",
                                      password_confirmation: "bar" }

    assert_template 'users/edit'
  end

  # 編集の成功に対するテスト
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    job = "学生"
    patch user_path(@user), params: { name:  name,
                                      email: email,
                                      password:              "",
                                      password_confirmation: "",
                                      job: job }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
    assert_equal job, @user.job
  end
end
