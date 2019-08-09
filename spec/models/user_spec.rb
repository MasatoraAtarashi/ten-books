require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with name, email, password and password_confirmation" do
    @user = User.new(
      name: "Example",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(@user).to be_valid
  end

  it "is invalid without name"
  # name 短い
  # name 長い
  it "is invalid without email"
  # email 長さ
  # email アドレスのフォーマット*2
  # email 小文字で
  it "is invalid with a duplicate email address"
  it "is invalid without password"
  # passwordの長い短い
end
