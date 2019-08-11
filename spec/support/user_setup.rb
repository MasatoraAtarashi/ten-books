RSpec.shared_context "user setup" do
  let!(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
end
