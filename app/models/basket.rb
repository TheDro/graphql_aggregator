class Basket < ApplicationRecord
  belongs_to :user
  has_many :basket_products, dependent: :destroy
  has_many :products, through: :basket_products

  def add_product(product, quantity = 1)
    basket_product = basket_products.find_or_initialize_by(product: product)
    basket_product.quantity = basket_product.quantity.to_i + quantity
    basket_product.save
  end

  def remove_product(product)
    basket_products.find_by(product: product)&.destroy
  end

  def total
    basket_products.sum { |bp| bp.product.price * bp.quantity }
  end
end
