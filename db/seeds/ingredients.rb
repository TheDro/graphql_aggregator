# Create ingredients
puts "Creating ingredients..."

ingredients = [
  { name: 'LED Screen', weight: 0.25 },
  { name: 'Glass Panel', weight: 0.5 },
  { name: 'Lithium Battery', weight: 0.15 },
  { name: 'Microchip', weight: 0.01 },
  { name: 'Plastic Housing', weight: 0.35 },
  { name: 'Aluminum Frame', weight: 0.4 },
  { name: 'Copper Wire', weight: 0.05 },
  { name: 'Rubber Gasket', weight: 0.03 },
  { name: 'Camera Module', weight: 0.08 },
  { name: 'Speaker', weight: 0.1 },
  { name: 'Microphone', weight: 0.02 },
  { name: 'Cooling Fan', weight: 0.12 },
  { name: 'Memory Module', weight: 0.03 },
  { name: 'Power Supply', weight: 0.45 },
  { name: 'Adhesive Tape', weight: 0.01 }
]

# Create or update ingredients
ingredients.each do |ingredient_attrs|
  ingredient = Ingredient.find_or_initialize_by(name: ingredient_attrs[:name])
  ingredient.update!(weight: ingredient_attrs[:weight])
  puts "Created ingredient: #{ingredient.name}"
end

puts "Created #{Ingredient.count} ingredients"
