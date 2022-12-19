class Address < ApplicationRecord
  belongs_to :customer
  
  validates :postcode
end
