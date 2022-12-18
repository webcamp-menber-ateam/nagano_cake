class Product < ApplicationRecord

  belongs_to :genre
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy
end