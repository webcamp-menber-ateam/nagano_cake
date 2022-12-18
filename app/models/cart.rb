class Cart < ApplicationRecord

  # アソシエーション
  belongs_to :customer
  belongs_to :product

  # バリデーション
  validates :amount, presence: true

  def subtoal
    product.with_tax_price * amount.to_i
  end

end

# nagano@cake
# 111111