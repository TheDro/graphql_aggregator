module Types
  class BasketType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :user, Types::UserType, null: false
    field :basket_products, [Types::BasketProductType], null: false
    field :products, [Types::ProductType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    
    field :total, Float, null: false, description: "The total cost of all items in the basket"
    field :item_count, Integer, null: false, description: "The total number of items in the basket"

    def total
      Loaders::SuperGoldiLoader.for(:total).wrap(object) do |object|
        object.total
      end
    end
    
    def item_count
      object.basket_products.sum(:quantity)
    end
  end
end
