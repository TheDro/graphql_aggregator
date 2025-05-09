module Types
  class IngredientType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :weight, Float, null: true
    field :products, [Types::ProductType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def products
      ultra_load(object, :products)
    end
  end
end
