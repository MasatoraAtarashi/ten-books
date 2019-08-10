require 'rails_helper'

RSpec.describe Book, type: :model do
  # 妥当性
  # 同じユーザーが同じ本(title,isbnともに同じもの)を登録しない
  it "does not allow duplicate book per user" do
    user = User.create(
      name: "Example",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user.books.create(
      title: "money ball",
      isbn: "9784274067938"
    )
    new_book = user.books.build(
      title: "money ball",
      isbn: "9784274067938"
    )
    new_book.valid?
    expect(new_book.errors[:isbn]).to include("has already been taken")
  end

  # isbnが違えば良い

  # titleが違えば良い

  # 違うユーザーが同じ本を登録するのは良い
  it "allows two users to share a book" do
    user = User.create(
      name: "Example",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user.books.create(
      title: "money ball",
      isbn: "9784274067938"
    )
    other_user = User.create(
      name: "Example",
      email: "other@example.com",
      password: "password",
      password_confirmation: "password"
    )
    other_book = other_user.books.build(
      title: "money ball",
      isbn: "9784274067938"
    )
    expect(other_book).to be_valid
  end

  # user_idが存在
  # ユーザーの持っている本を取得したときに最後に追加したやつが一番最初になっている
end
