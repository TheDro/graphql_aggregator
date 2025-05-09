# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # User queries
    field :users, [Types::UserType], null: false,
      description: "Returns a list of all users"
    def users
      User.all
    end
    
        field :ingredients, [Types::IngredientType], null: false do
          description "Get all ingredients"
        end
    
        def ingredients
          Ingredient.all
        end
    
        field :ingredient, Types::IngredientType, null: true do
          description "Get a specific ingredient by ID"
          argument :id, ID, required: true
        end
    
        def ingredient(id:)
          Ingredient.find_by(id: id)
        end

    field :user, Types::UserType, null: true,
      description: "Find a user by ID" do
      argument :id, ID, required: true
    end
    def user(id:)
      User.find_by(id: id)
    end

    # Product queries
    field :products, [Types::ProductType], null: false,
      description: "Returns a list of all products"
    def products
      Product.all
    end

    field :product, Types::ProductType, null: true,
      description: "Find a product by ID" do
      argument :id, ID, required: true
    end
    def product(id:)
      Product.find_by(id: id)
    end

    # Basket queries
    field :baskets, [Types::BasketType], null: false,
      description: "Returns a list of all baskets"
    def baskets
      Basket.all
    end

    field :basket, Types::BasketType, null: true,
      description: "Find a basket by ID" do
      argument :id, ID, required: true
    end
    def basket(id:)
      Basket.find_by(id: id)
    end

    # Current user query - to be used with authentication
    field :me, Types::UserType, null: true,
      description: "Returns the currently authenticated user"
    def me
      # In a real app, you would return the current user based on authorization
      # For now, return the test user
      User.first
    end
  end
end
