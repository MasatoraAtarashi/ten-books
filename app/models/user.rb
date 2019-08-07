class User < ApplicationRecord
  include SearchCop
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  mount_uploader :picture, PictureUploader
  validates :name, presence: true, length: { maximum: 16, minimum: 3 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password validations: false
  validates :password, presence: true, length: { maximum: 16, minimum: 6 }, allow_nil: true
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :active_relationships, class_name: "Like",
                   foreign_key: "user_id",
                   dependent:   :destroy
  has_many :likes, through: :active_relationships, source: :liked
  has_many :passive_relationships, class_name: "Like",
                   foreign_key: "liked_id",
                   dependent:   :destroy
  has_many :likeds, through: :passive_relationships, source: :user
  search_scope :search do
    attributes :name, :job
  end
  has_many :authorizations

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 本棚のランキングを返す
  def self.rank_shelves
    sql = 'SELECT liked_id FROM likes GROUP BY liked_id ORDER BY count(*) desc LIMIT 6;'
    user_ids = ActiveRecord::Base.connection.execute(sql).to_a
    shelves = []
    user_ids.each do |user_id|
      shelves << User.find_by(id: user_id)
    end
    return shelves
  end

  # 本棚のランキングを返す(すべての本棚)
  def self.rank_shelves_all
    sql = 'SELECT shelf.id FROM ( (SELECT users.id, count(*) as i FROM users JOIN likes on users.id = likes.liked_id GROUP BY likes.liked_id ORDER BY i ) UNION (SELECT users.id, 0 as i FROM users LEFT JOIN likes ON users.id = likes.liked_id WHERE liked_id is null) ) as shelf ORDER BY shelf.i desc;'
    user_ids = ActiveRecord::Base.connection.execute(sql).to_a
    shelves = []
    user_ids.each do |user_id|
      shelves << User.find_by(id: user_id)
    end
    return shelves
  end

  def self.create_from_auth!(auth)
  #authの情報を元にユーザー生成の処理を記述
  #auth["credentials"]にアクセストークン、シークレットなどの情報が入ってます。
  #auth["info"]["email"]にユーザーのメールアドレスが入ってます。(Twitterはnil)
    name = auth[:info][:name]
    email = auth[:info][:email]
    picture = auth[:info][:image]
    user = User.create(name: name, email: email, picture: picture)
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

   # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    p "----#{self.reset_token}------"
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # 本棚にいいねする
  def like(other_user)
    likes << other_user
  end

  # 本棚のいいねを解除する
  def unlike(other_user)
    active_relationships.find_by(liked_id: other_user.id).destroy
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def liking?(other_user)
    likes.include?(other_user)
  end

  private
    # email属性を小文字に変換する
    def downcase_email
      email.downcase!
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
