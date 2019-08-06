require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # ログインのテスト
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # ログイン→ログアウトのテスト
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # リンクの変更をテスト
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    # ログアウト
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "span.input-field", count: 1
  end

  # [remember me] チェックボックスのテスト
  test "login with remembering" do
    log_in_as(@user, remember_me: 'on')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    # クッキーを保存してログイン
    log_in_as(@user, remember_me: 'on')
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(@user, remember_me: 'off')
    assert_empty cookies['remember_token']
  end
end
