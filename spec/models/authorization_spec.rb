require 'rails_helper'

RSpec.describe Authorization, type: :model do
  include_context "user setup"
  before do
    @auth = Authorization.new(user_id: user.id,
                              uid: '1',
                              provider: 'facebook')
  end

  it "is valid" do
    expect(@auth).to be_valid
  end

  describe "validations" do
    it "is invalid without user_id" do
      @auth.user_id = nil
      @auth.valid?
      expect(@auth.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without uid" do
      @auth.uid = nil
      @auth.valid?
      expect(@auth.errors[:uid]).to include("can't be blank")
    end

    it "is invalid without provider" do
      @auth.provider = nil
      @auth.valid?
      expect(@auth.errors[:provider]).to include("can't be blank")
    end

    it "does not allow duplicate uid and provider" do
      @auth.save
      dup_auth = Authorization.new(
        user_id: user.id,
        uid: '1',
        provider: 'facebook'
      )
      dup_auth.valid?
      expect(dup_auth.errors[:uid]).to include("has already been taken")
    end
  end
end
