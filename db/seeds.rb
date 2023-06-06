require 'faker'

# DESTROYING

puts "Cleaning offers database..."
Offer.destroy_all

puts "Cleaning hotels database..."
Hotel.destroy_all

puts "Cleaning flights database..."
Flight.destroy_all

puts "Cleaning users database..."
User.destroy_all

# CREATING

puts "Creating 5 new users..."
5.times do
  User.create!(email: Faker::Internet.email, password: "123456")
end
puts "Creating 5 new offers..."
5.times do
  offer = Offer.create!(destination: Faker::Address.city, budget: Faker::Number.decimal(l_digits: 2), start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, user_id: User.all.sample.id)
  puts "Creating  new hotels..."
    Hotel.create!(price: Faker::Number.decimal(l_digits: 2), name: Faker::Coffee.blend_name, address: Faker::Address.street_address, offer_id: offer.id)

  puts "Creating  new flights..."
    Flight.create!(price: Faker::Number.decimal(l_digits: 2), departure: Faker::Date.in_date_period, arrival: Faker::Date.in_date_period, offer_id: offer.id)
    Flight.create!(price: Faker::Number.decimal(l_digits: 2), departure: Faker::Date.in_date_period, arrival: Faker::Date.in_date_period, offer_id: offer.id)
end
