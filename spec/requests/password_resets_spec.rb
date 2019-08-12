require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  include_context "user setup"

  before do
    ActionMailer::Base.deliveries.clear
  end

  describe "new" do
    it "responds successfully" do
      get new_password_reset_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "create" do
    context "as valid email" do
      it "sends password_reset mail" do
        post password_resets_path, params: { email: user.email }
        expect(user.reset_digest).to_not eq user.reload.reset_digest
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(flash[:info]).to include("パスワード再設定用のメールを送信しました")
        expect(response).to redirect_to root_url
      end
    end

    context "as invalid email" do
      it "redirects to password_resets new page" do
        post password_resets_path, params: { email: "" }
        expect(ActionMailer::Base.deliveries.size).to eq 0
        expect(flash[:danger]).to include("メールアドレスが正しくありません")
      end
    end
  end

  describe "edit" do
    # userのreset_tokenがnilになる。attr_accessorの値を保存する方法がわからない。フィーチャースペックだけにする？
    before do
      user.create_reset_digest
      user.send_password_reset_email
    end

    context "as valid user and Observe the deadline" do
      it "responds successfully" do
        user.activate
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response).to be_successful
        expect(response).to have_http_status "200"
        expect(response.body).to match "input type=\"hidden\" name=\"email\" id=\"email\" value=\"#{user.email}\""
      end
    end

    context "as not activated user" do
      it "redirects to root_url" do
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response).to redirect_to root_url
      end
    end

    context "as invalid token" do
      it "redirects to root_url" do
        get edit_password_reset_path('wrong token', email: user.email)
        expect(response).to redirect_to root_url
      end
    end

    context "as invalid email" do
      it "redirects to root_url" do
        get edit_password_reset_path(user.reset_token, email: "")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "update" do
    before do
      user.activate
      user.create_reset_digest
      user.send_password_reset_email
    end

    context "as valid password and confirmation" do
      it "updates password" do
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        password: "foobaz",
                        password_confirmation: "foobaz" }
        expect(flash[:success]).to eq "Password has been reset."
        expect(response).to redirect_to user
        post login_path, params: { email: user.email, password: 'password' }
        expect(flash[:danger]).to eq "アカウント名またはパスワードが正しくありません。"
        post login_path, params: { email: user.email, password: 'foobaz' }
        expect(response).to redirect_to user
      end
    end

    context "invalid password" do
      it "can not update password" do
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        password: "foobaz",
                        password_confirmation: "barquux" }
        expect(flash[:success]).to be_falsey
      end
    end

    context "as password is empty" do
      it "can not update password" do
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        password:  "",
                        password_confirmation: "" }
        expect(flash[:danger]).to eq "パスワードを入力してください"

      end
    end

    context "as expired token" do
      it "redirects to new password reset url" do
        user.update_attribute(:reset_sent_at, 3.hours.ago)
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        password: "foobaz",
                        password_confirmation: "foobaz" }
        expect(flash[:danger]).to eq "Password reset has expired."
        expect(response).to redirect_to new_password_reset_url
      end
    end
  end
end
