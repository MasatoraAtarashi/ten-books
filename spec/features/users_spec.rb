require 'rails_helper'

RSpec.feature "Users", type: :feature do
  include SigninSupport
  let!(:user) { FactoryBot.build(:user) }

  # アカウント登録
  scenario "create new user", js: true do
    visit root_path
    click_link "signup"
    expect(page).to have_content "新規登録"
    expect {
      fill_in "ユーザー名", with: user.name
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      fill_in "パスワード(確認)", with: user.password
      click_button "登録"
    }.to change(User, :count).by(1)
    expect(page).to have_content "#{user.name}"
  end

  # お気に入り登録
  scenario "user add shelf to favorites", js: true do
    @other = FactoryBot.create(:user)
    sign_in_as @other
    visit root_path
    expect {
      execute_script('window.scroll(0,10000);')
      click_link("一覧を見る")
      expect(page).to have_content "本棚一覧"
      expect(page).to have_content @other.name
      click_link "User", match: :first
      click_button "お気に入りに登録"
      expect(page).to have_content "の10冊"
      visit likes_user_path(@other)
    }.to change(Like, :count).by(1)
  end
end
