class Post < ApplicationRecord
  belongs_to :user

  validates :image, presence: true
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :body, presence: true, length: { minimum: 1, maximum: 250 }

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize_to_fill: [width, height], gravity: :center).processed
  end
end
