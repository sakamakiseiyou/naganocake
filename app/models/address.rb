class Address < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true
end
