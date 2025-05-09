class ProductIngredient < ApplicationRecord
  belongs_to :product
  belongs_to :ingredient

  validates :product_id, uniqueness: { scope: :ingredient_id }
end
