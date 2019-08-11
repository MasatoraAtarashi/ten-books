require 'rails_helper'

RSpec.describe "BookComments", type: :request do
  describe "GET /book_comments" do
    it "works! (now write some real specs)" do
      get book_comments_index_path
      expect(response).to have_http_status(200)
    end
  end
end
