# Create products if they don't exist
puts "Creating products..."

products = [
  { name: 'Smartphone', description: 'A high-end smartphone with premium features', price: 699.99 },
  { name: 'Laptop', description: 'Powerful laptop for work and gaming', price: 1299.99 },
  { name: 'Tablet', description: '10-inch tablet with retina display', price: 499.99 },
  { name: 'Smart Watch', description: 'Fitness and health tracking watch', price: 249.99 },
  { name: 'Wireless Earbuds', description: 'Noise-cancelling wireless earbuds', price: 149.99 },
  { name: 'Smart Speaker', description: 'Voice-controlled smart home speaker', price: 99.99 },
  { name: 'Camera', description: 'Digital camera with 4K video recording', price: 599.99 },
  { name: 'Gaming Console', description: 'Next-generation gaming console', price: 499.99 },
  { name: 'Wireless Headphones', description: 'Over-ear wireless headphones', price: 199.99 },
  { name: 'External Hard Drive', description: '1TB portable external hard drive', price: 79.99 }
]

# Create or update products
products.each do |product_attrs|
  product = Product.find_or_initialize_by(name: product_attrs[:name])
  product.update!(
    description: product_attrs[:description],
    price: product_attrs[:price]
  )
  puts "Created product: #{product.name}"
end

puts "Created #{Product.count} products"
