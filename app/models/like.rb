class Like < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :liked, class_name: "User"
  validates :user_id, presence: true
  validates :liked_id, presence: true
end
