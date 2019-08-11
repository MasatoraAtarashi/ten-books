require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do
  describe "GET /account_activations" do
    it "works! (now write some real specs)" do
      get account_activations_index_path
      expect(response).to have_http_status(200)
    end
  end
end
