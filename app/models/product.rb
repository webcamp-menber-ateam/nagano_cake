class Product < ApplicationRecord

 
  belongs_to :genre
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy

  def with_tax_price
    tax = 1.1
    (price * tax).floor
  end
end
