class Product < ApplicationRecord


  belongs_to :genre
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize_to_fill: [width, height], gravity: :center).processed
  end

  def with_tax_price
    tax = 1.1
    (price * tax).floor
  end
end
