class HotelsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @offer = Offer.last
    @hotel_data = [
      { name: "The Azure Oasis", address: "123 Main Street", rating: 4.5, price: 120 },
      { name: "Moonlit Retreat", address: "456 Elm Street", rating: 3.8, price: 80 },
      { name: "Stellar Heights", address: "789 Oak Street", rating: 4.2, price: 150 },
      { name: "Aurora Haven", address: "321 Pine Street", rating: 3.5, price: 90 },
      { name: "Twilight Manor", address: "654 Cedar Street", rating: 4.1, price: 130 },
      { name: "Serenity Springs", address: "987 Birch Street", rating: 3.9, price: 110 },
      { name: "The Radiant Crown", address: "234 Maple Street", rating: 4.6, price: 180 },
      { name: "Enchanted Gardens", address: "567 Walnut Street", rating: 4.0, price: 100 },
      { name: "Harmony Retreat", address: "890 Ash Street", rating: 3.7, price: 70 },
      { name: "Mystic Sands Resort", address: "432 Pineapple Street", rating: 4.3, price: 140 }
    ]
  end

  def new
    @hotel = Hotel.new
  end

  def create
    hotel_details = {
      # add price and adress
      name: hotel_params["hotel_title"].to_s,
      offer: Offer.last
    }
    @hotel = Hotel.new(hotel_details)
    @hotel.save
    redirect_to offer_path(@hotel.offer)
  end

  #   url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotelsByLocation?latitude=#{latitude}&longitude=#{longitude}&checkIn=#{longitude}&checkOut=#{longitude}&pageNumber=1&currencyCode=EUR")
  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true

  #   request = Net::HTTP::Get.new(url)
  #   request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
  #   request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

  #   hotel_response = http.request(request).read_body
  #   hotels = JSON.parse(hotel_response)

  #   hotels["data"]["data"].first(10).map do |hotel|
  #     {
  #       name: hotel["secondaryInfo"],
  #       rating: hotel["bubbleRating"]["rating"],
  #       price: hotel["priceDetails"],
  #       address: hotel["title"]
  #     }
  #   end
  # end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :rating, :price, :address)
  end
end
