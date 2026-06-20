# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing screens
Screen.destroy_all

# Create 4 screens
Screen.create!([
  {
    name: "Screen 1",
    screen_type: "Standard",
    capacity: 120,
    description: "Main auditorium, standard format"
  },
  {
    name: "Screen 2",
    screen_type: "Standard", 
    capacity: 80,
    description: "Medium auditorium, standard format"
  },
  {
    name: "Screen 3",
    screen_type: "PLF",
    capacity: 150,
    description: "Premium Large Format auditorium with enhanced sound"
  },
  {
    name: "Screen 4",
    screen_type: "Standard",
    capacity: 60,
    description: "Boutique screen, ideal for independent films"
  }
])

puts "Created #{Screen.count} screens"
