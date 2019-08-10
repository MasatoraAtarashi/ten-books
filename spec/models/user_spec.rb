require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
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
      it "is invalid with name is too short" do
        @user.name = "a" * 2
        @user.valid?
        expect(@user).to be_invalid
      end

      # name 長い
      it "is invalid with name is too long" do
        @user.name = "a" * 17
        @user.valid?
        expect(@user).to be_invalid
      end
    end

    # email
    describe "email" do
      it "is invalid without email" do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      # email 長さ
      it "is invalid with email is too long" do
        @user.email = "a" * 244 + "@example.com"
        @user.valid?
        expect(@user).to be_invalid
      end

      # email アドレスのフォーマット*2
      context "when format is valid" do
        it "is valid when format is valid" do
          valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                    first.last@foo.jp alice+bob@baz.cn]
          valid_addresses.each do |valid_address|
            @user.email = valid_address
            expect(@user).to be_valid, "#{valid_address.inspect} is invalid"
          end
        end
      end

      context "when format is invalid" do
        it "is invalid when format is invalid" do
          invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                                 foo@bar_baz.com foo@bar+baz.com]
          invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            expect(@user).to be_invalid, "#{invalid_address.inspect} is valid"
          end
        end
      end

      it "is invalid with a duplicate email address" do
        @user.save
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        duplicate_user.valid?
        expect(duplicate_user.errors[:email]).to include("has already been taken")
      end
    end

    describe "password" do
      it "is invalid without password" do
        @user.password = @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      # passwordの長い短い
      it "is invalid with password is too short" do
        @user.password = @user.password_confirmation = "a" * 5
        @user.valid?
        expect(@user).to be_invalid
      end

      it "is invalid with password is too long" do
        @user.password = @user.password_confirmation = "a" * 17
        @user.valid?
        expect(@user).to be_invalid
      end
    end
  end

  describe "instance method" do
    # authenticated?
    # 正常系
    # 失敗のテスト
    # ダイジェストが存在しない場合のauthenticated?のテスト
    # like関連
  end
  describe "class method" do
    # rank_shelves
    # rank_shelves_all
    # 正常系
    # 失敗のテスト
  end

  # has_many?のテスト+destroy
  # book
  # book_comments
  # active_relationships
  # passive_relationships
  # authorizations
end
