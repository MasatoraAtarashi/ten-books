require 'rails_helper'

RSpec.describe "BookComments", type: :request do
  describe "update" do
    context "valid user" do
      context "as new comment" do
        it "creates book comment" do

        end
      end

      context "as comment already exist" do
        context "as valid content" do

        end

        context "as empty content" do

        end
      end
    end

    context "invalid user" do
      context "as not logged in user" do

      end

      context "as incorrect user" do

      end
    end
  end
end
