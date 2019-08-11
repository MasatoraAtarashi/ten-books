require 'rails_helper'

RSpec.describe Like, type: :model do
  include_context "user setup"
  before do
    @like = Like.new(user_id: user.id, liked_id: other_user.id)
  end

  it "is valid" do
    expect(@like).to be_valid
  end

  describe "validations" do
    it "is invalid without user_id" do
      @like.user_id = nil
      @like.valid?
      expect(@like.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without liked_id" do
      @like.liked_id = nil
      @like.valid?
      expect(@like.errors[:liked_id]).to include("can't be blank")
    end
  end
end
