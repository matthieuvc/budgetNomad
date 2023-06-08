class HotelsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    create_hotel
  end


  def create_hotel
    results = Geocoder.search(destination)
  if results.present?
    latitude = results.first.latitude
    longitude = results.first.longitude
  else
    return puts " Error message"
  end


    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotelsByLocation?latitude=#{latitude}&longitude=#{longitude}&checkIn=#{longitude}&checkOut=#{longitude}&pageNumber=1&currencyCode=EUR")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    hotel_response = http.request(request).read_body
    hotels = JSON.parse(hotel_response)

    hotels["data"]["data"].first(10).map do |hotel|
      {
        name: hotel["secondaryInfo"],
        rating: hotel["bubbleRating"]["rating"],
        price: hotel["priceDetails"],
        address: hotel["title"]
      }
    end
  end
end

