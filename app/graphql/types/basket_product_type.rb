module Types
  class BasketProductType < Types::BaseObject
    field :id, ID, null: false
    field :basket_id, Integer, null: false
    field :product_id, Integer, null: false
    field :quantity, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    
    field :basket, Types::BasketType, null: false
    field :product, Types::ProductType, null: false
    field :subtotal, Float, null: false, description: "The subtotal for this product in the basket"
    
    def subtotal
      object.product.price * object.quantity
    end
  end
end
