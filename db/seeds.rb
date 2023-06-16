require 'faker'

# DESTROYING

puts "Cleaning hotels, flights, offersn activities and users database..."
Hotel.destroy_all
Flight.destroy_all
Offer.destroy_all
PackagingActivity.destroy_all
User.destroy_all

# CREATING

user_for_pins = User.create!(name: "User", email: "test@test.com", password: "123456")

puts "Creating 5 new users..."
5.times do
  User.create!(email: Faker::Internet.email, password: "123456")
end

gaby = User.create!(name: "Gaby", email: "gaby@test.com", password: "123456")

puts "Creating 36 default offers..."
puts "Creating10 new activities..."

PackagingActivity.create!(category: "Nightlife Package",
  activity1: "Saga Boat - Ultimate Party Cruise Adventure",
  activity2: "Pacha - Iconic Nightlife Extravaganza",
  activity3: "Amnesia - Unleash Your Party Spirit",
  activity4: "Ushuia - Unforgettable Beachfront Party Paradise",
  city: "Ibiza",
  rating: 5,
  description: "Enjoy a fantastic boat party experience with live music, dancing, and breathtaking views of Ibiza's coastline.",
  price: 50,
  picture:"nigh.png")

  PackagingActivity.create!(
    category: "Nightlife Package",
    activity1: "Sun, sand, and lively parties at Ocean Beach.",
    activity2: "Non-stop dancing to infectious beats at Hï .",
    activity3: "Awe-inspiring dancefloor at the iconic Privilege",
    activity4: "Underground music paradise found at DC-10.",
    city: "Ibiza",
    rating: 4,
    description: "Experience the vibrant nightlife of Ibiza at renowned clubs, offering world-class DJs, energetic atmosphere, and unforgettable parties.",
    price: 60,
    picture:"nigh.png"
  )

PackagingActivity.create!(category: "Nightlife Package",
    activity1: "Breathtaking sunsets and vibrant nightlife on Sunset Strip.",
    activity2: "Unforgettable moments at Café Mambo, sipping cocktails and enjoying music.",
    activity3: "Immersive and enchanting experiences await at Es Paradis",
    activity4: "Unleash your party spirit at the legendary Eden.",
    city: "Ibiza",
    rating: 4,
    description: "Immerse yourself in the magical sunset vibes of Ibiza's famous Sunset Strip, featuring iconic bars, stunning views, and chill-out music.",
    price: 40,
    picture:"nigh.png"
  )

PackagingActivity.create!( category: "Adventure Package",
    activity1: "Kayaking in Coves",
    activity2: "Rock Climbing in Sa Talaia",
    activity3: "Mountain Biking in  Trails",
    activity4: "Coasteering in Ibiza's Coastline",
    city: "Ibiza",
    rating: 4,
    description: "Embark on thrilling adventures in Ibiza's natural landscapes, from kayaking through stunning coves to rock climbing and mountain biking in picturesque trails.",
    price: 80,
    picture:"adventure1.png"
  )

PackagingActivity.create!(category: "Thrilling Adventures",activity1: "Scuba Diving in Ibiza's Marine Reserve", activity2: "Paragliding over Ibiza's Coast", activity3: "Jet Skiing in the Mediterranean",activity4: "Hiking to Es Vedrà", city: "Ibiza", rating: 4, description: "Experience adrenaline-pumping adventure activities in Ibiza, including scuba diving in the marine reserve, paragliding with breathtaking views, jet skiing in the crystal-clear waters, and hiking to the iconic Es Vedrà.",price: 120, picture:"adventure1.png")

PackagingActivity.create!(
    category: "Adventure Package",
    activity1: "Yoga and Meditation Retreat ",
    activity2: "Wellness and Spa Retreat",
    activity3: "Mindfulness Retreat in Nature",
    activity4: "Fitness and Detox Retreat in",
    city: "Ibiza",
    rating: 4,
    description: "Indulge in rejuvenating retreat experiences in Ibiza, where you can immerse yourself in yoga and meditation, pamper with wellness treatments and spa therapies, practice mindfulness amidst nature, or focus on fitness and detoxification.",
    price: 150,
    picture:"Tranquil.png"
  )

PackagingActivity.create!(
    category: "Relaxation Package",
    activity1: "Holistic Healing Retreat ",
    activity2: "Art and Creativity Retreat ",
    activity3: "Transformational Retreat in Sacred Sites",
    activity4: "Spiritual Retreat ",
    city: "Ibiza",
    rating: 4,
    description: "Embark on transformative retreats in Ibiza, where you can experience holistic healing modalities, unleash your creativity through art workshops, explore the island's sacred sites for personal growth, or engage in spiritual practices for inner peace and awakening.",
    price: 200,
    picture:"Tranquil.png")

PackagingActivity.create!(
    category: "Culinary Package",
    activity1: "Gourmet Food Tour",
    activity2: "Cooking Classes with Local Chefs",
    activity3: "Wine Tasting and Vineyard Tour",
    activity4: "Farm-to-Table Dining Experience",
    city: "Ibiza",
    rating: 4,
    description: "Immerse yourself in the culinary delights of Ibiza with a variety of gastronomic experiences. Indulge in a gourmet food tour to savor the local cuisine, learn the art of cooking from expert chefs in cooking classes, embark on a wine tasting journey and vineyard tour, or enjoy a farm-to-table dining experience showcasing the freshest local ingredients.",
    price: 80,
    picture:"paella.png")

PackagingActivity.create!(
    category: "Culinary Package",
    activity1: "Food and Wine Tasting Tour",
    activity2: "Cooking Classes with Local Chefs",
    activity3: "Farm-to-Table Dining Experience",
    activity4: "Gastronomic Walking Tour of Town",
    city: "Ibiza",
    rating: 4,
    description: "Immerse yourself in the culinary delights of Ibiza with a range of gastronomic experiences. Take a food and wine tasting tour to sample local delicacies and wines, learn the art of cooking from skilled local chefs in interactive cooking classes, enjoy a farm-to-table dining experience with fresh and organic ingredients, and explore the flavors of Ibiza on a gastronomic walking tour through Ibiza Town.",
    price: 100,
    picture:"paella.png")

  PackagingActivity.create!(
    category: "Culinary Package",
    activity1: "Seafood Cooking Workshop",
    activity2: "Paella Masterclass",
    activity3: "Tapas Tasting and Wine Pairing",
    activity4: "Cheese and Wine Pairing Experience",
    city: "Ibiza",
    rating: 4,
    description: "Delve into the culinary traditions of Ibiza with hands-on culinary workshops and tastings. Learn the secrets of preparing seafood dishes in a cooking workshop, master the art of making authentic Ibiza paella in a dedicated masterclass, indulge in a tapas tasting experience with perfectly paired wines, and explore the world of cheese and wine pairing in a dedicated session.",
    price: 80,
    picture:"paella.png")

PackagingActivity.create!(
    category: "Relaxation Package",
    activity1: "Yoga and Meditation Retreat in Nature",
    activity2: "Spa and Wellness Retreat",
    activity3: "Holistic Healing Workshops",
    activity4: "Mindfulness and Stress Management Retreat",
    city: "Ibiza",
    rating: 4,
    description: "Immerse yourself in a wellness retreat in Ibiza, where you can rejuvenate your mind, body, and soul. Experience a tranquil yoga and meditation retreat amidst nature's beauty, indulge in luxurious spa treatments and wellness therapies, participate in holistic healing workshops to nurture your well-being, or join a mindfulness and stress management retreat to find inner peace and balance.",
    price: 120,
    picture:"Tranquil.png"
    )

PackagingActivity.create!(
    category: "Creativity Package",
    activity1: "Street Art Tour and Graffiti Workshop",
    activity2: "Painting and Wine Tasting Experience",
    activity3: "Artistic Photography Tour",
    activity4: "Sculpture Making Workshop",
    city: "Ibiza",
    rating: 4,
    description: "Embark on an artistic immersion in Ibiza, where you can explore and express your creativity. Take a street art tour to discover vibrant murals and participate in a graffiti workshop to create your own urban art. Engage in a painting session while enjoying a wine tasting experience. Join an artistic photography tour to capture the beauty of Ibiza through your lens. Unleash your sculpting skills in a hands-on sculpture making workshop.",
    price: 90,
    picture:"art.png"
    )

  Offer.create!(destination: "Berlin", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1305, localisation: "Brussels", latitude: 13.4050, longitude: 52.5200, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Milan", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1750, localisation: "Brussels", latitude: 9.1900, longitude: 45.4642, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Alicante", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 800, localisation: "Brussels", latitude: -0.4810, longitude: 38.3452, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Porto", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 950, localisation: "Brussels", latitude: -8.6291, longitude: 41.1579, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Genéva", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1800, localisation: "Brussels", latitude: 6.1432, longitude: 46.2044, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Paris", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1200, localisation: "Brussels", latitude: 2.3522, longitude: 48.8566, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Barcelona", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1500, localisation: "Brussels", latitude: 2.1734, longitude: 41.3851, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Berlin", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1000, localisation: "Brussels", latitude: 13.4049, longitude: 52.5200, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Amsterdam", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1350, localisation: "Brussels", latitude: 4.8970, longitude: 52.3779, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Rome", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1700, localisation: "Brussels", latitude: 12.4964, longitude: 41.9028, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Madrid", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1300, localisation: "Brussels", latitude: -3.7038, longitude: 40.4168, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "London", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1600, localisation: "Brussels", latitude: -0.1276, longitude: 51.5074, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Vienna", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1100, localisation: "Brussels", latitude: 16.3738, longitude: 48.2082, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Lisbon", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1250, localisation: "Brussels", latitude: -9.1393, longitude: 38.7223, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Dublin", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1450, localisation: "Brussels", latitude: -6.2603, longitude: 53.3498, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Ibiza", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1600, localisation: "Brussels", latitude: 1.4351, longitude: 38.9085, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Athens", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1500, localisation: "Brussels", latitude: 23.7275, longitude: 37.9838, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Tokyo", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 2000, localisation: "Brussels", latitude: 139.6917, longitude: 35.6895, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Bali", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1500, localisation: "Brussels", latitude: 115.0920, longitude: -8.3405, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Cairo", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1800, localisation: "Brussels", latitude: 31.2357, longitude: 30.0444, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Marrakech", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 2000, localisation: "Brussels", latitude: -7.9811, longitude: 31.6295, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Cape Town", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1500, localisation: "Brussels", latitude: 18.4241, longitude: -33.9249, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Zanzibar City", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1700, localisation: "Brussels", latitude: 39.1990, longitude: -6.1659, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Mombasa", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 2000, localisation: "Brussels", latitude: 39.6682, longitude: -4.0435, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Prague", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1500, localisation: "Brussels", latitude: 14.4378, longitude: 50.0755, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Budapest", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1300, localisation: "Brussels", latitude: 19.0402, longitude: 47.4979, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Krakow", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1200, localisation: "Brussels", latitude: 19.9450, longitude: 50.0647, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Sofia", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1000, localisation: "Brussels", latitude: 23.3219, longitude: 42.6977, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)
  Offer.create!(destination: "Warsaw", start_date: Faker::Date.in_date_period(month: Date.today.month), end_date: Faker::Date.in_date_period(month: Date.today.month + 1), budget: 1400, localisation: "Brussels", latitude: 21.0122, longitude: 52.2297, user_id: user_for_pins.id, packaging_activity_id: PackagingActivity.all.sample.id)

# Offer 1
offer1 = Offer.create!(
  destination: "Paris",
  budget: 2000,
  start_date: Date.today + 7,
  end_date: Date.today + 14,
  user_id: gaby.id,
  localisation: "Brussels",
  longitude: 2.3522,
  latitude: 48.8566,
  packaging_activity_id: PackagingActivity.first
)

Flight.create!(
  price: 500,
  departure: DateTime.now,
  arrival: DateTime.now + 3.hours,
  offer_id: offer1.id,
  depart_location: "Brussels",
  arrival_location: "Paris"
)

Hotel.create!(
  price: 1000,
  name: "Luxury Hotel",
  address: "123 Main Street, Paris",
  offer_id: offer1.id,
  rating: 5,
  num_nights: 7,
  picture: "ibizahotel5.png"
)

# Offer 2
offer2 = Offer.create!(
  destination: "Barcelona",
  budget: 1500,
  start_date: Date.today - 30,
  end_date: Date.today - 23,
  user_id: gaby.id,
  localisation: "Brussels",
  longitude: 2.1734,
  latitude: 41.3851,
  packaging_activity_id: PackagingActivity.last
)

Flight.create!(
  price: 400,
  departure: DateTime.now,
  arrival: DateTime.now + 2.5.hours,
  offer_id: offer2.id,
  depart_location: "Brussels",
  arrival_location: "Barcelona"
)

Hotel.create!(
  price: 800,
  name: "Cozy Hotel",
  address: "456 Main Street, Barcelona",
  offer_id: offer2.id,
  rating: 4,
  num_nights: 7,
  picture: "ibizahotel1.png"
)
