class User < ApplicationRecord
  before_save :downcase
  validates :name, presence: true, length: { maximum: 16, minimum: 3 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { maximum: 16, minimum: 6 }

  private
    # email属性を小文字に変換する
    def downcase
      email.downcase!
    end
end
