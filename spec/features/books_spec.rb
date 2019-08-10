require 'rails_helper'

RSpec.feature "Books", type: :feature do
  # 新しい本を登録する
  scenario "user add a new book", js: true do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "login"
    expect(page).to have_content "ログイン"

    fill_in "メールアドレス", with: user.email
    p user.email
    fill_in "パスワード", with: user.password
    p user.password
    click_button "login-button"

    expect(page).to have_content "#{user.name}"

    expect {
      key = "book"
      fill_in "search-field", with: key
      click_link "search-button"
      expect(page).to have_content "#{key}"
      click_button "本棚に追加", match: :first
    }.to change(Book, :count).by(1)
  end

  # アカウント登録

  # お気に入り登録

  # 本のランキング

  # 本棚ランキング
end
