require 'rails_helper'
RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe "show" do
    it "responds successfully" do
      get user_path(user)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "new" do
    it "responds successfully" do
      get signup_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "create" do
    it "add a user" do
      user_params = FactoryBot.attributes_for(:user)
      expect {
        post users_path, params: user_params
      }.to change(User, :count).by(1)
    end
  end

  describe "edit" do
    context "as logged in and correct user" do
      it "responds successfully" do
        log_in_as user
        get edit_user_path(user)
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    context "as not logged in user" do
      it "redirects login_url" do
        get edit_user_path(user)
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end

    context "as wrong user" do
      it "redirects root_url" do
        log_in_as other_user
        get edit_user_path(user)
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "update" do
  end

  describe "edit_image" do
  end

  describe "update_image" do
  end

  describe "destroy" do
    context "as admin and logged in user" do
    end

    context "as not logged in user" do
    end

    context "as not admin user" do
    end
  end

  describe "index" do
  end

  describe "likes" do

  end
end
