require 'rails_helper'

RSpec.describe "UsersApis", type: :request do
  describe "GET /users_apis" do
    it "works! (now write some real specs)" do
      get '/api/users'
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.length).to eq User.count
      expect(User.find(json[0]["id"])).to be_truthy
    end
  end
end
