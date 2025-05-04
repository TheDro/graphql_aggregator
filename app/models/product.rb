class Product < ApplicationRecord
  has_many :basket_products, dependent: :destroy
  has_many :baskets, through: :basket_products

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
