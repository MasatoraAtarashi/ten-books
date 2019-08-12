require 'rails_helper'

RSpec.describe "BookComments", type: :request do
  include_context "user setup"
  before do
    @book = user.books.create()
    @content = "comment"
  end

  describe "update" do
    context "valid user" do
      before do
        log_in_as user
      end

      context "as new comment" do
        it "creates book comment" do
          expect {
            post "/book_comments/#{@book.id}", params: { user_id: user.id, content: @content }
          }.to change(BookComment, :count).by(1)
          expect(response).to redirect_to @book
        end
      end

      context "as comment already exist" do
        before do
          @book_comment = @book.book_comments.create(user_id: user.id, content: @content)
        end

        context "as valid content" do
          it "updates book comment" do
            post "/book_comments/#{@book.id}", params: { user_id: user.id, content: "another" }
            expect(BookComment.find_by(user_id: user.id, book_id: @book.id).content).to eq "another"
            expect(response).to redirect_to @book
          end
        end

        context "as empty content" do
          it "deletes book comment" do
            expect {
              post "/book_comments/#{@book.id}", params: { user_id: user.id, content: "" }
            }.to change(BookComment, :count).by(-1)
            expect(response).to redirect_to @book
          end
        end
      end
    end

    context "invalid user" do
      context "as not logged in user" do
        it "redirects to log_in url" do
          post "/book_comments/#{@book.id}", params: { user_id: user.id, content: @content }
          expect(response).to redirect_to login_url
        end
      end

      context "as incorrect user" do
        it "redirects to root url" do
          log_in_as other_user
          post "/book_comments/#{@book.id}", params: { user_id: user.id, content: @content }
          expect(response).to redirect_to root_url
        end
      end
    end
  end
end
