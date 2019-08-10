require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      name: "Example",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "is valid with name, email, password and password_confirmation" do
    expect(@user).to be_valid
  end

  describe "validations" do
    describe "name" do
      it "is invalid without name" do
        @user.name = nil
        @user.valid?
        expect(@user.errors[:name]).to include("can't be blank")
      end

      # name 短い
      # name 長い
    end

    describe "email" do
      it "is invalid without email" do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      # email 長さ
      # email アドレスのフォーマット*2
      context "when format is valid" do
        it "is valid when format is valid"
      end

      context "when format is invalid" do
        it "is invalid when format is invalid"
      end
      # email 小文字で
      it "is invalid with a duplicate email address" do
        @user.save
        user = User.new(
          name: "second",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        )
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end

      #emailのユニーク、大文字でもだめ
    end

    describe "password" do
      it "is invalid without password" do
        @user.password = @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end
      # passwordの長い短い
    end
  end

  describe "instance method" do
  end
  describe "class method" do
  end






  # インスタンスメソッドのテスト
  # 正常系
  # 失敗のテスト
  # クラスメソッドのテスト
end
