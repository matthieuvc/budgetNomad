class OffersController < ApplicationController
  def index
    @flight_data = create_flight()
    @hotel_data = create_hotel()
    render json: { flight_data: @flight_data, hotel_data: @hotel_data }
  end

  # def create
  #   @offer = Offer.new(offer_params)

  #   @offer.save
  #   redirect_to
  # end

  # def update

  # end

  private

  def offer_params

  end

  require 'uri'
require 'net/http'
require 'json'

def create_flight
  url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchFlights?sourceAirportCode=BOM&destinationAirportCode=DEL&date=2023-06-07&itineraryType=ONE_WAY&sortOrder=PRICE&numAdults=1&numSeniors=0&classOfService=ECONOMY&pageNumber=1&currencyCode=USD")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
  request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

  flight_response = http.request(request).read_body
  flight = JSON.parse(flight_response)

  departure_time = flight["data"]["flights"][0]["segments"][0]["legs"][0]["departureDateTime"]
  depart_location = flight["data"]["flights"][0]["segments"][0]["legs"][0]["originStationCode"]
  arrival_time = flight["data"]["flights"][0]["segments"][0]["legs"][0]["arrivalDateTime"]
  arrival_location = flight["data"]["flights"][0]["segments"][0]["legs"][0]["destinationStationCode"]
  price_per_passenger = flight["data"]["flights"][0]["purchaseLinks"][0]["totalPricePerPassenger"]

  {
    departure_time: departure_time,
    depart_location: depart_location,
    arrival_time: arrival_time,
    arrival_location: arrival_location,
    price_per_passenger: price_per_passenger
  }
end

def create_hotel
  url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotelsByLocation?latitude=40.730610&longitude=-73.935242&checkIn=%3CREQUIRED%3E&checkOut=%3CREQUIRED%3E&pageNumber=1&currencyCode=USD")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
  request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

  hotel_response = http.request(request).read_body
  hotel = JSON.parse(hotel_response)

  hotel_title = hotel["data"]["data"][0]["title"]
  hotel_rating = hotel["data"]["data"][0]["bubbleRating"]["rating"]
  hotel_picture = hotel["data"]["data"][0]["cardPhotos"][0]["sizes"]["urlTemplate"]
end
