class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 1, maximum: 26}
  validates :email, presence: true

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォローできるユーザを取り出す
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォローしているユーザを取り出す
  has_many :following_user, through: :follower, source: :followed #自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower #自分をフォローしている人

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_fill: [width, height], gravity: :center).processed
  end
  # ゲストユーザの検索・作成を自動的に判断して処理を行うメソッド
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  #ユーザをフォローする
  def follow(user_id)
    follower.create(follower: user_id)
  end

  # ユーザのフォローを外す
  def unfollow(user)
    follower.find_by(followed: user_id).destroy
  end
  #フォローしていればtrueを返す
  def following?(user)
    following_user.include?(followed_id: user)
  end
end
