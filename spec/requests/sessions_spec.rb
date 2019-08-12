require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  include_context "user setup"

  describe "new" do
    it "responds successfully" do
      get login_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "create" do
    context "valid user" do
      context "remember" do
        it "login user with remember" do
          post login_path, params: { email: user.email, password: user.password, remember_me: 'on' }
          expect(is_logged_in?).to be_truthy
          expect(cookies['remember_token']).to eq assigns(:user).remember_token
          expect(response).to redirect_to user
        end
      end

      context "not remember" do
        it "login user" do
          post login_path, params: { email: user.email, password: user.password }
          expect(is_logged_in?).to be_truthy
          expect(cookies['remember_token']).to be_falsey
          expect(response).to redirect_to user
        end
      end
    end

    context "incorrect email" do
      it "denies user login" do
        post login_path, params: { email: 'incorrect@example.com', password: user.password }
        expect(flash[:danger]).to eq 'アカウント名またはパスワードが正しくありません。'
        expect(is_logged_in?).to be_falsey
      end
    end

    context "incorrect password" do
      it "denies user login" do
        post login_path, params: { email: user.email, password: 'incorrect' }
        expect(flash[:danger]).to eq 'アカウント名またはパスワードが正しくありません。'
        expect(is_logged_in?).to be_falsey
      end
    end

    context "empty password" do
      it "denies user login" do
        post login_path, params: { email: user.email, password: '' }
        expect(flash[:danger]).to eq 'アカウント名またはパスワードが正しくありません。'
        expect(is_logged_in?).to be_falsey
      end
    end
  end

  describe "destroy" do
    it "logout user" do
      log_in_as user
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(response).to redirect_to root_url
      expect(is_logged_in?).to be_falsey
    end
  end
end
