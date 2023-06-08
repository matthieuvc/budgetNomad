class OffersController < ApplicationController
  def show
    @offer = Offer.find(params[:id])
    raise
  end

  def index
    @offer = Offer.new
    @offers = Offer.all
    @flight_data =  [{:departure_time=>"2023-06-07T20:10:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T22:40:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>60.2}, {:departure_time=>"2023-06-07T15:45:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T17:55:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>67.52}, {:departure_time=>"2023-06-07T21:00:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T23:10:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>69}, {:departure_time=>"2023-06-07T22:35:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T23:45:00+05:30", :arrival_location=>"GOI", :price_per_passenger=>113.44}, {:departure_time=>"2023-06-07T22:05:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-08T00:55:00+05:30", :arrival_location=>"ATQ", :price_per_passenger=>123.97}, {:departure_time=>"2023-06-07T23:25:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-08T07:25:00+08:00", :arrival_location=>"KUL", :price_per_passenger=>657.45}]
    @hotel_data = [{:hotel_title=>"1. Homewood Suites by Hilton New York/Midtown Manhattan Times Square-South, NY", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/74/3b/fe/exterior.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"2. Hampton Inn Manhattan / Times Square Central", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/7f/cb/1f/exterior.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"3. Ace Hotel Brooklyn", :hotel_rating=>5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1d/88/65/31/the-lobby-at-ace-hotel.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"4. Pod 51 Hotel", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/28/9d/6c/d4/pod-roof.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"5. Opera House Hotel", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/7f/46/ba/superior-king--v12464873.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"6. Truss Hotel Times Square", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/23/c3/b0/bf/truss-hotel.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"7. Crowne Plaza Times Square Manhattan, an IHG Hotel", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/0e/d2/62/the-crowne-plaza-times.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"8. YOTEL New York Times Square", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/99/35/6e/yotel-new-york-entrance.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"9. Envue, Autograph Collection", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/37/c1/85/nohu-rooftop-bar-restaurant.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"10. Hampton Inn New York - LaGuardia Airport", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/79/a7/11/exterior.jpg?w={width}&h={height}&s=1"}]
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

  private

  def offer_params
    params.require(:offer).permit(:destination, :budget, :start_date, :end_date)
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
    flights = JSON.parse(flight_response)

    flights["data"]["flights"].first(10).map do |flight|
      {
        departure_time: flight["segments"][0]["legs"][0]["departureDateTime"],
        depart_location: flight["segments"][0]["legs"][0]["originStationCode"],
        arrival_time: flight["segments"][0]["legs"][0]["arrivalDateTime"],
        arrival_location: flight["segments"][0]["legs"][0]["destinationStationCode"],
        price_per_passenger: flight["purchaseLinks"][0]["totalPricePerPassenger"]
      }
    end
  end

  def create_hotel
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotelsByLocation?latitude=40.730610&longitude=-73.935242&checkIn=2023-06-06&checkOut=2023-06-07&pageNumber=1&currencyCode=USD")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    hotel_response = http.request(request).read_body
    hotels = JSON.parse(hotel_response)

    hotels["data"]["data"].first(10).map do |hotel|
      {
        hotel_title: hotel["title"],
        hotel_rating: hotel["bubbleRating"]["rating"],
        hotel_picture: hotel["cardPhotos"][0]["sizes"]["urlTemplate"]
      }
    end
  end
end
