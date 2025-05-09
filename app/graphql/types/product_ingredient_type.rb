module Types
  class ProductIngredientType < Types::BaseObject
    field :id, ID, null: false
    field :product_id, Integer, null: false
    field :ingredient_id, Integer, null: false
    field :product, Types::ProductType, null: false
    field :ingredient, Types::IngredientType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def product
      ultra_load(object, :product)
    end

    def ingredient
      ultra_load(object, :ingredient)
    end
  end
end
