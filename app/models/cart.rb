class Cart < ApplicationRecord

  # アソシエーション
  belongs_to :customer
  belongs_to :product

  # バリデーション
  validates :amount, presence: true

  def with_tax_price
    tax = 1.1
    (product_id.to_i * tax).floor
    # (price.to_i * 1.1).floor
  end

  def subtoal
    self.with_tax_price * amount.to_i
  end

end
