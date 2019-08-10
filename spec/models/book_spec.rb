require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @book = @user.books.create(title: "book", isbn: "1234567891011")
  end

  # 妥当性
  it "is valid" do
    expect(@book).to be_valid
  end

  describe "validations" do
    # 同じユーザーが同じ本(title,isbnともに同じもの)を登録しない
    it "does not allow duplicate book per user" do
      duplicate_book = @user.books.build(
        title: @book.title,
        isbn: @book.isbn
      )
      duplicate_book.valid?
      expect(duplicate_book.errors[:isbn]).to include("has already been taken")
    end

    # isbnが違えば良い
    it "allows same title book and different isbn per user" do
      book = @user.books.build(
        title: @book.title,
        isbn: '1101987654321'
      )
      book.valid?
      expect(book).to be_valid
    end

    # titleが違えば良い
    it "allows same isbn book and different title per user" do
      book = @user.books.build(
        title: 'other book',
        isbn: @book.isbn
      )
      book.valid?
      expect(book).to be_valid
    end

    # 違うユーザーが同じ本を登録するのは良い
    it "allows two users to share a book" do
      other_user = FactoryBot.create(:user)
      other_book = other_user.books.build(
        title: @book.title,
        isbn: @book.isbn
      )
      expect(other_book).to be_valid
    end

    # user_idが存在
    it "is invalid without user_id" do
      book = FactoryBot.build(:book)
      book.valid?
      expect(book.errors[:user_id]).to include("can't be blank")
    end
  end

  describe "class_method" do
  end

  # ユーザーの持っている本を取得したときに最後に追加したやつが一番最初になっている
end
