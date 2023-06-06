# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts "let's create some hotel offer "

url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotelsByLocation?latitude=40.730610&longitude=-73.935242&checkIn=%3CREQUIRED%3E&checkOut=%3CREQUIRED%3E&pageNumber=1&currencyCode=USD")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

hotel_response = http.request(request)
puts response.read_body

flight_response = http.request(request).read_body
flight_response_ok = JSON.parse(response)
puts "hotel  offer has been created succesfully"
