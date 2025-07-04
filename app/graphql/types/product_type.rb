module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :price, Float, null: false
    field :stock_quantity, Integer, null: false
    field :image_url, String, null: true
    field :ingredients, [Types::IngredientType], null: false
    field :product_ingredients, [Types::ProductIngredientType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :weight, Float, null: false

    def weight
      ultra_wrap(object) do |product|
        product.ingredients.sum(&:weight)
      end
    end

    def ingredients
      ultra_load(object, :ingredients)
    end
    
    def product_ingredients
      ultra_load(object, :product_ingredients)
    end
    
    field :baskets, [Types::BasketType], null: false
    def baskets
      object.baskets
    end

    field :available, Boolean, null: false, description: "Whether the product is in stock"
    
    def available
      object.stock_quantity > 0
    end
  end
end
