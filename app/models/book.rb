class Book < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :isbn, uniqueness: { scope: [:user_id, :title] }
  has_many :book_comments

  # 本のランキングを返す(6件)
  def self.rank_books
    sql = 'SELECT title, image_link, info_link, count(*) as count FROM books GROUP BY title, image_link, info_link ORDER BY count desc LIMIT 6;'
    ActiveRecord::Base.connection.execute(sql).to_a
  end

  # 本のランキングを返す(すべて)
  def self.rank_books_all
    sql = 'SELECT title, image_link, info_link, count(*) as count, authors, published_date, id FROM books GROUP BY title, image_link, info_link, authors, published_date, id ORDER BY count desc;'
    ActiveRecord::Base.connection.execute(sql).to_a
  end
end
