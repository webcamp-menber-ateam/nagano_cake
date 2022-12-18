class Product < ApplicationRecord

  belongs_to :genre
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true
  enum is_active: { sale: true, stop_selling: false }
  validates :is_active, presence: true, inclusion: { in: [true, false] }

  has_one_attached :image
  def get_image
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image
  end
end
