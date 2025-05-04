class BasketProduct < ApplicationRecord
  belongs_to :basket
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
end
