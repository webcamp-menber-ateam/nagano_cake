class OrderDetail < ApplicationRecord
  enum creat_status: { not_start: 0, waiting_for_production: 1, now_at_work: 2, created: 3 }
  belongs_to :order
  belongs_to :product

  def subtoal
    product.with_tax_price * amount.to_i
  end
end
