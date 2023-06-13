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
User.create!(name: "User", email: "test@test.com", password: "123456")

5.times do
  User.create!(email: Faker::Internet.email, password: "123456")
end

puts "Creating 5 new offers..."
Offer.create!(destination: "Berlin", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, budget: 1200, localisation: "Brussels", latitude: 13.4050, longitude: 52.5200, user_id: User.all.sample.id)
Offer.create!(destination: "Milan", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, budget: 1750, localisation: "Brussels", latitude: 9.1900, longitude: 45.4642, user_id: User.all.sample.id)
Offer.create!(destination: "Alicante", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, budget: 800, localisation: "Brussels", latitude: 0.4907, longitude: 38.3460, user_id: User.all.sample.id)
Offer.create!(destination: "Oporto", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, budget: 950, localisation: "Brussels", latitude: 8.6291, longitude: 41.1579, user_id: User.all.sample.id)
Offer.create!(destination: "Genéva", start_date: Faker::Date.in_date_period, end_date: Faker::Date.in_date_period, budget: 1800, localisation: "Brussels", latitude: 6.1432, longitude: 46.2044, user_id: User.all.sample.id)

# myobject.tap do |o|
#   o.my_method
# end

# .tap do |offer|
#   offer.create_flight!()
#   offer.create_hotel!()
#   offer.create_activity!()
# end
