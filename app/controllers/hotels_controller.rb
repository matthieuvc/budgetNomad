class HotelsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @offer = Offer.find(params[:offer_id])
    #@hotel_data = fetch_hotels
    @hotel_data = [{:name=>"Aparthotel Vibra Jabeque Soul", :rating=>4, :price=>121, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/dc/40/76/p.jpg?w=400&h=300&s=1"}, {:name=>"Hard Rock Hotel Ibiza", :rating=>4.5, :price=>143, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/90/2e/17/hard-rock-hotel-ibiza.jpg?w=400&h=300&s=1"}, {:name=>"Ushuaia Ibiza Beach Hotel", :rating=>4.5, :price=>91, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0c/c2/56/37/pool-building.jpg?w=400&h=300&s=1"}, {:name=>"3. Grand Palladium White Island Resort & Spa", :rating=>4.5, :price=>138, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/f1/6c/ca/grand-palladium-white.jpg?w=400&h=300&s=1"}, {:name=>"4. Hotel Torre del Mar", :rating=>4.5, :price=>114, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/08/39/91/infinity-pool.jpg?w=400&h=300&s=1"}, {:name=>"5. ME Ibiza - The Leading Hotels of the World", :rating=>4.5, :price=>109, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/6b/02/13/me-ibiza-the-leading.jpg?w=400&h=300&s=1"}, {:name=>"Suncoast Ibiza Hotel - Adults Only -", :rating=>3.5, :price=>116, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/24/8a/a9/7d/doble-room.jpg?w=400&h=300&s=1"}, {:name=>"6. Palladium Hotel Palmyra", :rating=>4.5, :price=>108, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/8e/6a/8a/palladium-hotel-palmyra.jpg?w=400&h=300&s=1"}, {:name=>"7. TRS Ibiza Hotel", :rating=>4.5, :price=>83, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/52/5c/c5/signature-level-suite.jpg?w=400&h=300&s=1"}, {:name=>"8. Grand Palladium Palace Ibiza Resort & Spa", :rating=>4.5, :price=>102, :address=>nil, :picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/7d/8d/49/piscina.jpg?w=400&h=300&s=1"}]
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
    request["X-RapidAPI-Key"] = '1d9f5d7888msha32a10e846bf6f6p1f8d3bjsn911b18232b2e'
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
    request["X-RapidAPI-Key"] = '1d9f5d7888msha32a10e846bf6f6p1f8d3bjsn911b18232b2e'
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
