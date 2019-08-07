class Authorization < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }


  def self.find_from_auth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

  def self.create_from_auth(auth, user = nil)
    user ||= User.create_from_auth!(auth)
    Authorization.create!(:user => user, :uid => auth['uid'], :provider => auth['provider'])
  end
end
