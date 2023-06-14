class HotelsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @offer = Offer.find(params[:offer_id])
    @hotel_data = fetch_hotels
    # @hotel_data = [
    #   { name: "Moonlit Retreat", address: "456 Elm Street", rating: 3.8, price: 80, picture:"ibizahotel2.png"},
    #   { name: "Aurora Haven", address: "321 Pine Street", rating: 3.5, price: 90, picture:"ibizahotel4.png"},
    #   { name: "Serenity Springs", address: "987 Birch Street", rating: 3.9, price: 110, picture:"ibizahotel5.png"},
    #   { name: "The Azure Oasis", address: "123 Main Street", rating: 4.5, price: 120, picture: "ibzahotel1.png"},
    #   { name: "Stellar Heights", address: "789 Oak Street", rating: 4.2, price: 150, picture:"ibizahotel3.png"},
    # ]
  end

  def new
    @hotel = Hotel.new
  end

  def create
    puts "Num Nights: #{params[:num_nights]}"

    hotel_details = {
      name: hotel_params["name"],
      address: hotel_params["address"],
      rating: hotel_params["rating"],
      price: hotel_params["price"],
      num_nights: mights_params[:num_nights],
      picture: hotel_params["picture"]
    }
    @hotel = Hotel.new(hotel_details)
    #@offer = Offer.find(params[:offer_id])
    @offer = Offer.last
    @hotel.offer = @offer
    @hotel.save!
    redirect_to packaging_activities_path(offer_id: @offer.id, hotel_id: @hotel.id)
  end

  def geoId
    destination = @offer.destination
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchLocation?query=#{destination}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '503a48dfecmsh69c31a138b3f12dp189e0bjsn731e815fb930'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    response = http.request(request).read_body
    location = JSON.parse(response)

    string = location["data"][0]["geoId"]
    array = string.partition(";")[2].partition(";")
    return array[0]

  end

  def fetch_hotels

    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotels?geoId=#{geoId}&checkIn=2023-06-14&checkOut=2023-06-15&pageNumber=1&currencyCode=USD")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '503a48dfecmsh69c31a138b3f12dp189e0bjsn731e815fb930'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    response = http.request(request).read_body
    hotels = JSON.parse(response)

    hotels["data"]["data"].first(10).map do |hotel|
      {
        name: hotel["title"],
        rating: hotel["bubbleRating"]["rating"],
        price: rand(80..150),
        address: hotel["secondaryInfo"],
        picture: hotel["cardPhotos"][0]["sizes"]["urlTemplate"].partition("?")[0] + "?w=400&h=300&s=1"
      }
    end
  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :rating, :price, :address, :picture, :num_nights)
  end

  def mights_params
    params.permit(:num_nights)
  end
end
