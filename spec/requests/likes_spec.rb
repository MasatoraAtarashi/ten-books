require 'rails_helper'

RSpec.describe "Likes", type: :request do
  include_context "user setup"

  describe "create" do
    context "as logged in user" do
      it "add a like" do
        log_in_as user
        expect {
          post likes_path, params: { liked_id: other_user.id }
        }.to change(Like, :count).by(1)
      end
    end

    context "as not logged in user" do
      it "redirects to login_url" do
        post likes_path, params: { liked_id: other_user.id }
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "destroy" do
    context "as logged in user" do
      it "destroy a like" do
        log_in_as user
        like = Like.create(user_id: user.id, liked_id: other_user.id)
        expect {
          delete like_path(like.id)
        }.to change(Like, :count).by(-1)
      end
    end

    context "as not logged in user" do
      it "redirects to login_url" do
        like = Like.create(user_id: user.id, liked_id: other_user.id)
        delete like_path(like.id)
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end
  end
end
