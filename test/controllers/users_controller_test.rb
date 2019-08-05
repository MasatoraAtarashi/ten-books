require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should get edit_image" do
    log_in_as(@user)
    get "/users/#{@user.id}/image"
    assert_response :success
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get likes" do
    log_in_as(@user)
    get likes_user_path(@user)
    assert_response :success
  end

  # editとupdateアクションの保護に対するテスト
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { name: @user.name,
                                      email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # 間違ったユーザーが編集しようとしたときのテスト
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { name: @user.name,
                                              email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # edit_mageとupdate_imageアクションの保護に対するテスト
  test "should redirect edit_image when not logged in" do
    get "/users/#{@user.id}/image"
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update_image when not logged in" do
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    patch "/users/#{@user.id}/image", params: { picture: picture }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # 間違ったユーザーが編集しようとしたときのテスト
  test "should redirect edit_image when logged in as wrong user" do
    log_in_as(@other_user)
    get "/users/#{@user.id}/image"
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update_image when logged in as wrong user" do
    log_in_as(@other_user)
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    patch "/users/#{@user.id}/image", params: { picture: picture }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # likesアクションの保護に対するテスト
  test "should redirect likes when not logged in" do
    get likes_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect likes when logged in as wrong user" do
    log_in_as(@other_user)
    get likes_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  # admin属性の変更が禁止されていることをテストする
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { password: @other_user.password ,                                                        password_confirmation: @other_user.password,                                            admin: true }
    assert_not @other_user.reload.admin?
  end

  # 管理者権限の制御をアクションレベルでテストする
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
