class Address < ApplicationRecord
  belongs_to :customer

  validates :postcode, presence: true, length: { is: 7 }, numericality: {only_integer: true}
  validates :address, presence: true, length: { minimum: 4 }
  validates :name, presence: true, length: { minimum: 2 }
end
