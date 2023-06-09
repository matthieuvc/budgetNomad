class HotelsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @offer = Offer.last
    @hotel_data = [
      { name: "The Azure Oasis", address: "123 Main Street", rating: 4.5, price: 120, picture: "ibzahotel1.png"},
      { name: "Moonlit Retreat", address: "456 Elm Street", rating: 3.8, price: 80, picture:"ibizahotel2.png"},
      { name: "Stellar Heights", address: "789 Oak Street", rating: 4.2, price: 150, picture:"ibizahotel3.png"},
      { name: "Aurora Haven", address: "321 Pine Street", rating: 3.5, price: 90, picture:"ibizahotel4.png"},
      { name: "Serenity Springs", address: "987 Birch Street", rating: 3.9, price: 110, picture:"ibizahotel5.png"},
    ]
  end

  def new
    @hotel = Hotel.new
  end

  def create
    hotel_details = {
      # add price and adress
      name: hotel_params["name"],
      address: hotel_params["address"],
      rating: hotel_params["rating"],
      price: hotel_params["price"],
    }
    # raise
    @hotel = Hotel.new(hotel_details)
    @offer = Offer.find(params[:offer])
    @hotel.offer = Offer.find(params[:offer])
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
    params.require(:hotel).permit(:name, :rating, :price, :address, :picture)
  end
end
