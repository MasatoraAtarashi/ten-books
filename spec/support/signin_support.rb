module SigninSupport
  def sign_in_as(user)
    visit root_path
    click_link "login"
    expect(page).to have_content "ログイン"

    fill_in "メールアドレス", with: user.email
    p user.email
    fill_in "パスワード", with: user.password
    p user.password
    click_button "login-button"

    expect(page).to have_content "#{user.name}"
  end
end
