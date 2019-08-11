require 'rails_helper'

RSpec.feature "Books", type: :feature do
  include SigninSupport

  # 新しい本を登録する
  scenario "user add a new book", js: true do
    user = FactoryBot.create(:user)

    sign_in_as user

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
