class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :image, presence: true
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :body, presence: true, length: { minimum: 1, maximum: 300 }

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize_to_fill: [width, height], gravity: :center).processed
  end

  def self.search(word)
    if word != ""
    Post.where(['title LIKE? or body LIKE?', "%#{word}%", "%#{word}%"])
    end
  end
  # Favoritesテーブル内にuserが存在（exists?）するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
