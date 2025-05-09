class Product < ApplicationRecord
  has_many :basket_products, dependent: :destroy
  has_many :baskets, through: :basket_products
  
  has_many :product_ingredients, dependent: :destroy
  has_many :ingredients, through: :product_ingredients

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
