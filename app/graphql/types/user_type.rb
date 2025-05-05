module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    
    field :basket, Types::BasketType, null: true
    field :full_name, String, null: true, description: "The user's full name"
    
    def full_name
      [object.first_name, object.last_name].compact.join(' ')
    end
  end
end
