require 'rails_helper'

RSpec.describe BookComment, type: :model do
  include_context "user setup"
  before do
    book = user.books.create()
    @book_comment = book.book_comments.new(user_id: user.id, content: "comment")
  end

  it "is valid" do
    expect(@book_comment).to be_valid
  end

  describe "validation" do
    it "is invalid without user_id" do
      @book_comment.user_id = nil
      @book_comment.valid?
      expect(@book_comment.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without book_id" do
      @book_comment.book_id = nil
      @book_comment.valid?
      expect(@book_comment.errors[:book_id]).to include("can't be blank")
    end

    it "is invalid without content" do
      @book_comment.content = nil
      @book_comment.valid?
      expect(@book_comment.errors[:content]).to include("can't be blank")
    end
  end
end
