class CreateBasketProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :basket_products do |t|
      t.references :basket, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
    
    add_index :basket_products, [:basket_id, :product_id], unique: true
  end
end
