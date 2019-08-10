require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @other = FactoryBot.create(:user)
    @book = FactoryBot.create(:book, user: @user)
  end

  describe "#search" do
    # 正常
    #
  end

  describe "#create" do
    # 正常
    context "as authenticated user" do
      it "add a book" do
        other_book = FactoryBot.build(:book, :other)
        log_in @user
        expect {
          post :create, params: { title: other_book.title, isbn: other_book.isbn }
        }.to change(Book, :count).by(1)
      end
    end

    # ログインしてない
    context "as a guest" do
      it "does not add a book" do
      end

      it "redirects to the log-in page" do
      end
    end
  end

  describe "#destroy" do
    # 正常
    context "as authenticated user" do
      it "redirects to the log-in page" do
        log_in @user
        expect {
          delete :destroy, params: { id: @book.id }
        }.to change(Book, :count).by(-1)
      end
    end

    # ログインしてない
    context "as a guest" do
      it "does not delete the book" do
        expect {
          delete :destroy, params: { id: @book.id }
        }.to_not change(Book, :count)
      end

      it "redirects to the log-in page" do
        delete :destroy, params: { id: @book.id }
        expect(response).to redirect_to login_url
      end
    end

    # 異なるユーザー
    context "as a incorrect user" do
      it "does not delete the book" do
        log_in @other
        expect {
          delete :destroy, params: { id: @book.id }
        }.to_not change(Book, :count)
      end

      it "redirects to the log-in page" do
        log_in @other
        delete :destroy, params: { id: @book.id }
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "#index" do
    # 正常
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "#show" do
    # 正常
  end
end
