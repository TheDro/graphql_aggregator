# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create test user
user = User.create!(
  email: 'test@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Test',
  last_name: 'User'
)

# Create products
products = [
  {
    name: 'Laptop',
    description: 'High-performance laptop for all your computing needs',
    price: 1299.99,
    stock_quantity: 10,
    image_url: 'https://example.com/laptop.jpg'
  },
  {
    name: 'Smartphone',
    description: 'Latest smartphone with advanced camera features',
    price: 899.99,
    stock_quantity: 15,
    image_url: 'https://example.com/smartphone.jpg'
  },
  {
    name: 'Headphones',
    description: 'Noise-cancelling headphones for immersive audio experience',
    price: 299.99,
    stock_quantity: 20,
    image_url: 'https://example.com/headphones.jpg'
  },
  {
    name: 'Tablet',
    description: 'Lightweight tablet perfect for reading and browsing',
    price: 499.99,
    stock_quantity: 8,
    image_url: 'https://example.com/tablet.jpg'
  },
  {
    name: 'Smartwatch',
    description: 'Feature-rich smartwatch with fitness tracking capabilities',
    price: 249.99,
    stock_quantity: 12,
    image_url: 'https://example.com/smartwatch.jpg'
  }
]

products.each do |product_attrs|
  Product.create!(product_attrs)
end

# Add some products to the user's basket
basket = user.basket
basket.add_product(Product.first, 2)
basket.add_product(Product.third, 1)

puts "Seeded database with #{User.count} users, #{Product.count} products, and #{BasketProduct.count} basket products."
