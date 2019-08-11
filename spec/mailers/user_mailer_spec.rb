require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user)}
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe "account activation_email" do
    before do
      @mail = user.send_activation_email
    end

    it "sends a account activation mail" do
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end

    it "sends a welcome email to the user's email address" do
      expect(@mail.to).to eq [user.email]
    end

    it "sends from the support email address" do
      expect(@mail.from).to eq ["noreply@example.com"]
    end

    it "sends with the correct subject" do
      expect(@mail.subject).to eq "Account activation"
    end
    # bodyのテストはうまくいかない
  end

  describe "password_reset_email" do
    before do
      user.create_reset_digest
      @mail = user.send_password_reset_email
    end

    it "sends a account activation mail" do
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end

    it "sends a welcome email to the user's email address" do
      expect(@mail.to).to eq [user.email]
    end

    it "sends from the support email address" do
      expect(@mail.from).to eq ["noreply@example.com"]
    end

    it "sends with the correct subject" do
      expect(@mail.subject).to eq "Password reset"
    end
  end
end
