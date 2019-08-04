class Book < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :isbn, uniqueness: { scope: [:user_id, :title] }

  # 本のランキングを返す
  def self.rank_books
    sql = 'SELECT title, image_link, info_link, count(*) as count FROM books GROUP BY title, image_link, info_link ORDER BY count desc LIMIT 6;'
    ActiveRecord::Base.connection.execute(sql).to_a
  end
end
