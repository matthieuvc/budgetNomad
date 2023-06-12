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
# 5.times do
#   offer = Offer.create!(destination: Faker::Address.city, budget: Faker::Number.decimal(l_digits: 2), start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, user_id: User.all.sample.id)
#   puts "Creating  new hotels..."
#     Hotel.create!(price: Faker::Number.decimal(l_digits: 2), name: Faker::Coffee.blend_name, address: Faker::Address.street_address, offer_id: offer.id)

#   puts "Creating  new flights..."
#     Flight.create!(price: Faker::Number.decimal(l_digits: 2), departure: Faker::Date.in_date_period, arrival: Faker::Date.in_date_period, offer_id: offer.id)
#     Flight.create!(price: Faker::Number.decimal(l_digits: 2), departure: Faker::Date.in_date_period, arrival: Faker::Date.in_date_period, offer_id: offer.id)
# end

offer1 = Offer.create!(destination: "Berlin", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, min_budget: 0, max_budget: 1200, localisation: "Brussels", latitude: 13.4050, longitude: 52.5200, user_id: User.all.sample.id)

offer2 = Offer.create!(destination: "Milan", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, min_budget: 0, max_budget: 1750, localisation: "Brussels", latitude: 9.1900, longitude: 45.4642, user_id: User.all.sample.id)

offer3 = Offer.create!(destination: "Alicante", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, min_budget: 0, max_budget: 800, localisation: "Brussels", latitude: 0.4907, longitude: 38.3460, user_id: User.all.sample.id)

offer4 = Offer.create!(destination: "Oporto", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, min_budget: 0, max_budget: 950, localisation: "Brussels", latitude: 8.6291, longitude: 41.1579, user_id: User.all.sample.id)

offer5 = Offer.create!(destination: "Genéva", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, min_budget: 0, max_budget: 1800, localisation: "Brussels", latitude: 6.1432, longitude: 46.2044, user_id: User.all.sample.id)
