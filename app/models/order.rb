class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_for_payment: 0, payment_confirmation: 1, now_at_work: 2, shipping_preparation: 3, sent: 4 }
  belongs_to :customer
  has_many :order_details, dependent: :destroy

end
