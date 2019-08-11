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
    context "as logged in and correct user" do
      it "updates a user" do
        user_params = FactoryBot.attributes_for(:user)
        log_in_as user
        patch user_path(user), params: user_params
        expect(user.reload.email).to eq user_params[:email]
        expect(response).to redirect_to user_url(user)
      end
    end

    context "as not logged in user" do
      it "redirects login_url" do
        user_params = FactoryBot.attributes_for(:user)
        patch user_path(user), params: user_params
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end

    context "as wrong user" do
      it "redirects root_url" do
        user_params = FactoryBot.attributes_for(:user)
        log_in_as other_user
        patch user_path(user), params: user_params
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "edit_image" do
    context "as admin and logged in user" do
      it "edits a user image" do
        log_in_as user
        get "/users/#{user.id}/image"
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    context "as not logged in user" do
      it "redirects login_url" do
        get "/users/#{user.id}/image"
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end

    context "as wrong user" do
      it "redirects root_url" do
        log_in_as other_user
        get "/users/#{user.id}/image"
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "update_image" do
    context "as logged in and correct user" do
      it "updates a user image" do
        log_in_as user
        picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
        patch "/users/#{user.id}/image", params: { user: { picture: picture } }
        # eqで画像を比べる方法がわからなかった
        expect(response).to_not be_successful
        expect(response).to redirect_to "/users/#{user.id}/image"
      end
    end

    context "as not logged in user" do
      it "redirects login_url" do
        picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
        patch "/users/#{user.id}/image", params: { user: { picture: picture } }
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end

    context "as wrong user" do
      it "redirects root_url" do
        log_in_as other_user
        picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
        patch "/users/#{user.id}/image", params: { user: { picture: picture } }
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "destroy" do
    context "as admin and logged in user" do
      it "deletes a user" do
        admin_user = FactoryBot.create(:user, :admin)
        log_in_as admin_user
        user #letの遅延評価のため
        expect {
          delete user_path(user)
        }.to change(User, :count).by(-1)
      end
    end

    context "as not logged in user" do
      it "redirects login_url" do
        delete user_path(user)
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end

    context "as not admin user" do
      it "redirects root_url" do
        log_in_as other_user
        delete user_path(user)
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
    # 今のところdeleteを送れば自分も消せる。adminなら　一方adminじゃないと消せない
  end

  describe "index" do
    it "responds successfully" do
      get users_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "likes" do
    context "as admin and logged in user" do
      it "responds successfully" do
        log_in_as user
        get likes_user_path(user)
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    context "as not logged in user" do
      it "redirects login_url" do
        get likes_user_path(user)
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end

    context "as wrong user" do
      it "redirects root_url" do
        log_in_as other_user
        get likes_user_path(user)
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end
end
