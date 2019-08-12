require 'rails_helper'

RSpec.feature "Books", type: :feature do
  include SigninSupport
  let!(:user) { FactoryBot.create(:user) }

  # 新しい本を登録する
  scenario "user add a new book", js: true do
    sign_in_as user

    expect {
      key = "book"
      fill_in "search-field", with: key
      click_link "search-button"
      expect(page).to have_content "#{key}"
      click_button "本棚に追加", match: :first
    }.to change(Book, :count).by(1)
  end

  # 本のランキング
  scenario "show book ranking" do
    visit root_path
    click_link "もっと見る"
    expect(page).to have_content "登録されている本一覧"
  end

  # 本棚ランキング
  scenario "show shelf ranking" do
    visit root_path
    click_link "一覧を見る"
    expect(page).to have_content "本棚一覧"
    expect(page).to have_content user.name
  end
end
