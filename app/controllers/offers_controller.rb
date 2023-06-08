class OffersController < ApplicationController

  def index
    @offers = Offer.all

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user

    @offer.save
    redirect_to offer_path(@offer)
  end

  # def update (WILL ONLY BE USED WHEN WE APPLY CATEGORIES)
  #   @offer = Offer.find(params[:id])
  #   @offer.update(offer_params)

  #   redirect_to offer_path(@offer)
  # end


  def offer_params
    params.require(:offer).permit(:destination, :budget, :start_date, :end_date)
  end
end

  # require 'uri'
  # require 'net/http'
  # require 'json'

  # def create_flight
  #   url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchFlights?sourceAirportCode=BOM&destinationAirportCode=DEL&date=2023-06-07&itineraryType=ONE_WAY&sortOrder=PRICE&numAdults=1&numSeniors=0&classOfService=ECONOMY&pageNumber=1&currencyCode=USD")

  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true

  #   request = Net::HTTP::Get.new(url)
  #   request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
  #   request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

  #   flight_response = http.request(request).read_body
  #   flights = JSON.parse(flight_response)

  #   flights["data"]["flights"].first(10).map do |flight|
  #     {
  #       departure_time: flight["segments"][0]["legs"][0]["departureDateTime"],
  #       depart_location: flight["segments"][0]["legs"][0]["originStationCode"],
  #       arrival_time: flight["segments"][0]["legs"][0]["arrivalDateTime"],
  #       arrival_location: flight["segments"][0]["legs"][0]["destinationStationCode"],
  #       price_per_passenger: flight["purchaseLinks"][0]["totalPricePerPassenger"]
  #     }
  #   end
  # end

  # def create_hotel
  #   url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotelsByLocation?latitude=40.730610&longitude=-73.935242&checkIn=2023-06-06&checkOut=2023-06-07&pageNumber=1&currencyCode=USD")

  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true

  #   request = Net::HTTP::Get.new(url)
  #   request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
  #   request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

  #   hotel_response = http.request(request).read_body
  #   hotels = JSON.parse(hotel_response)

  #   hotels["data"]["data"].first(10).map do |hotel|
  #     {
  #       hotel_title: hotel["title"],
  #       hotel_rating: hotel["bubbleRating"]["rating"],
  #       hotel_picture: hotel["cardPhotos"][0]["sizes"]["urlTemplate"]
  #     }
  #   end
  end
