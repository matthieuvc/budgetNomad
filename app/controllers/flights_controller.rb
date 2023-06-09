class FlightsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @offer = Offer.last
    @flight_data = [
      {
        localisation: "BRUXELLES CHARLEROI AIRPORT",
        destination: "IBIZA AIRPORT",
        start_date: "2023-06-07T20:10:00+05:30",
        end_date: "2023-06-07T22:40:00+05:30",
        price_per_passenger: 60.2
      },
      {
        localisation: "BRUXELLES AIRPORT",
        destination: "BARCELONE AIRPORT",
        start_date: "2023-06-07T15:45:00+05:30",
        end_date: "2023-06-07T17:55:00+05:30",
        price_per_passenger: 67.52
      },
      {
        localisation: "BRUXELLES CHARLEROI AIRPORT",
        destination: "ALICANTE AIRPORT",
        start_date: "2023-06-07",
        end_date: "2023-06-07",
        price_per_passenger: 69
      },
      {
        localisation: "BRUXELLES AIRPORT",
        destination: "MADRID AIRPORT",
        start_date: "2023-06-07T22:35:00+05:30",
        end_date: "2023-06-07T23:45:00+05:30",
        price_per_passenger: 113.44
      },
      {
        localisation: "BRUXELLES CHARLEROI AIRPORT",
        destination: "PALMA DE MALLORCA",
        start_date: "2023-06-07T22:05:00+05:30",
        end_date: "2023-06-08T00:55:00+05:30",
        price_per_passenger: 123.97
      }
    ]
  end

  def new
    @flight = Flight.new
  end

  def create
    flight_details = {
      departure: flight_params["start_date"].to_datetime,
      arrival: flight_params["end_date"].to_datetime,
      depart_location: flight_params["localisation"],
      arrival_location: flight_params["destination"],
      price: flight_params["price_per_passenger"].to_f
    }

    @flight = Flight.new(flight_details)
    @offer = Offer.find(params[:offer])
    @flight.offer = Offer.find(params[:offer])
    @flight.save
    redirect_to hotels_path(offer: @offer)
  end

  private

  def flight_params
    params.require(:flight).permit(:localisation, :destination, :budget, :start_date, :end_date, :price_per_passenger)
  end

#   def source_airport_code
#     localisation = params[:localisation]
#     url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchAirport?query=#{localisation}")

#     http = Net::HTTP.new(url.host, url.port)
#     http.use_ssl = true

#     request = Net::HTTP::Get.new(url)
#     request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
#     request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

#     airport_response1 = http.request(request).read_body
#     airport = JSON.parse(airport_response1)

#     return airport["data"][0]["airportCode"]
#   end

#   def destination_airport_code
#     url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchAirport?query=#{params[:destination]}")

#     http = Net::HTTP.new(url.host, url.port)
#     http.use_ssl = true

#     request = Net::HTTP::Get.new(url)
#     request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
#     request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

#     airport_response2 = http.request(request).read_body
#     airport2 = JSON.parse(airport_response2)

#     return airport2["data"][0]["airportCode"]
#   end




#     http = Net::HTTP.new(url.host, url.port)
#     http.use_ssl = true

#     request = Net::HTTP::Get.new(url)
#     request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
#     request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

#     flight_response = http.request(request).read_body
#     flights = JSON.parse(flight_response)

#     flights["data"]["flights"].first(10).map do |flight|
#       {
#         departure: flight["segments"][0]["legs"][0]["departureDateTime"],
#         depart_location: flight["segments"][0]["legs"][0]["originStationCode"],
#         arrival: flight["segments"][0]["legs"][0]["arrivalDateTime"],
#         arrival_location: flight["segments"][0]["legs"][0]["destinationStationCode"],
#         price_per_passenger: flight["purchaseLinks"][0]["totalPricePerPassenger"]
#       }
#     end
#   end

#   def create_flight(source_code, destination_code, date)
#     # this is just a comment
#     fetch_flights(source_code, destination_code, date)
#   end
end
