# Associate products with ingredients
puts "Creating product-ingredient associations..."

# Make sure we have some products to work with
if Product.count == 0
  puts "No products found. Creating sample products first..."
  
  products = [
    { name: 'Smartphone', description: 'A high-end smartphone with premium features', price: 699.99 },
    { name: 'Laptop', description: 'Powerful laptop for work and gaming', price: 1299.99 },
    { name: 'Tablet', description: '10-inch tablet with retina display', price: 499.99 },
    { name: 'Smart Watch', description: 'Fitness and health tracking watch', price: 249.99 },
    { name: 'Wireless Earbuds', description: 'Noise-cancelling wireless earbuds', price: 149.99 }
  ]
  
  products.each do |product_attrs|
    Product.create!(product_attrs)
  end
  
  puts "Created #{Product.count} products"
end

# Define which ingredients are used in which products
product_ingredient_associations = {
  'Smartphone' => ['LED Screen', 'Glass Panel', 'Lithium Battery', 'Microchip', 'Plastic Housing', 'Camera Module', 'Speaker', 'Microphone', 'Memory Module', 'Adhesive Tape'],
  'Laptop' => ['LED Screen', 'Lithium Battery', 'Microchip', 'Plastic Housing', 'Aluminum Frame', 'Copper Wire', 'Cooling Fan', 'Memory Module', 'Power Supply', 'Speaker', 'Microphone'],
  'Tablet' => ['LED Screen', 'Glass Panel', 'Lithium Battery', 'Microchip', 'Aluminum Frame', 'Camera Module', 'Speaker', 'Memory Module'],
  'Smart Watch' => ['LED Screen', 'Lithium Battery', 'Microchip', 'Aluminum Frame', 'Rubber Gasket', 'Adhesive Tape'],
  'Wireless Earbuds' => ['Plastic Housing', 'Lithium Battery', 'Microchip', 'Speaker', 'Microphone', 'Rubber Gasket']
}

# Clear existing associations
ProductIngredient.destroy_all
puts "Cleared existing product-ingredient associations"

# Create new associations
product_ingredient_associations.each do |product_name, ingredient_names|
  product = Product.find_by(name: product_name)
  
  if product
    ingredient_names.each do |ingredient_name|
      ingredient = Ingredient.find_by(name: ingredient_name)
      
      if ingredient
        ProductIngredient.create!(product: product, ingredient: ingredient)
        puts "Associated '#{product_name}' with '#{ingredient_name}'"
      else
        puts "Warning: Ingredient '#{ingredient_name}' not found"
      end
    end
  else
    puts "Warning: Product '#{product_name}' not found"
  end
end

puts "Created #{ProductIngredient.count} product-ingredient associations"
