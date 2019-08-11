require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let!(:user) { FactoryBot.create(:user, :activated) }
  let(:other_user) { FactoryBot.create(:user) }

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

      end
    end

    context "as not activated user" do

    end

    context "as invalid token" do

    end

    context "as invalid email" do

    end

    context "as expired token" do

    end
  end

  describe "update" do
    context "as valid user and Observe the deadline" do

    end

    context "as invalid user" do

    end

    context "as expired token" do

    end
  end
end
