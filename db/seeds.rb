require 'faker'

# DESTROYING

puts "Cleaning hotels, flights, offers and users database..."
Hotel.destroy_all
Flight.destroy_all
Offer.destroy_all
User.destroy_all

# CREATING

puts "Creating 5 new users..."
5.times do
  User.create!(email: Faker::Internet.email, password: "123456")
end

User.create!(name: "User", email: "test@test.com", password: "123456")

puts "Creating 5 default offers..."

Offer.create!(destination: "Berlin", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1305, localisation: "Brussels", latitude: 13.4050, longitude: 52.5200, user_id: User.all.sample.id).tap do |offer|
  offer.create_flight!(price: 285, departure_outbound: "", departure_inbound: "", depart_location: "", arrival_location: "",return_outbound: "", return_inbound: "")
  offer.create_hotel!(price: 350, name: "", address: "", rating: 4, num_nights: 2, picture: "")
  offer.create_activity!(category: "", rating: 5, description: "", city: "", price: 320, picture: "", activity1: "", activity2: "", activity3: "", activity4: "")
end

Offer.create!(destination: "Milan", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1750, localisation: "Brussels", latitude: 9.1900, longitude: 45.4642, user_id: User.all.sample.id)

Offer.create!(destination: "Alicante", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 800, localisation: "Brussels", latitude: 0.4907, longitude: 38.3460, user_id: User.all.sample.id)

Offer.create!(destination: "Oporto", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 950, localisation: "Brussels", latitude: 8.6291, longitude: 41.1579, user_id: User.all.sample.id)

Offer.create!(destination: "Genéva", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1800, localisation: "Brussels", latitude: 6.1432, longitude: 46.2044, user_id: User.all.sample.id)

# myobject.tap do |o|
#   o.my_method
# end
