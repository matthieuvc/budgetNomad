class FlightsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'


  def index
    @offer = Offer.last
    @flight_data =  [{:departure=>"2023-06-09T16:00:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T18:20:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>59}, {:departure=>"2023-06-09T12:50:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T14:45:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>61}, {:departure=>"2023-06-09T06:00:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T08:05:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>61}, {:departure=>"2023-06-09T02:30:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T04:40:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>60.91}, {:departure=>"2023-06-09T08:45:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T10:55:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>61}, {:departure=>"2023-06-09T22:50:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-10T01:00:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>61}, {:departure=>"2023-06-09T05:00:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T07:15:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>60.91}, {:departure=>"2023-06-09T21:55:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-10T00:10:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>61}, {:departure=>"2023-06-09T11:45:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T14:05:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>61}, {:departure=>"2023-06-09T15:45:00+05:30", :depart_location=>"BOM", :arrival=>"2023-06-09T18:10:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>61}]
    # airport_code = source_airport_code
    #create_flight
  end

  def new
    @flight = Flight.new
  end

  def create
    flight_details = {
      departure: flight_params["start_date"].to_datetime,
      arrival: flight_params["end_date"].to_datetime,
      price: flight_params["price_per_passenger"].to_f,
      offer: Offer.last
    }
    @flight = Flight.new(flight_details)
    @flight.save
    redirect_to hotels_path
  end

  private

  def flight_params
    params.require(:flight).permit(:localisation, :destination, :budget, :start_date, :end_date, :price_per_passenger)
  end

  def source_airport_code
    localisation = params[:localisation]
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchAirport?query=#{localisation}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    airport_response1 = http.request(request).read_body
    airport = JSON.parse(airport_response1)

    return airport["data"][0]["airportCode"]
  end

  def destination_airport_code
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchAirport?query=#{destination}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    airport_response2 = http.request(request).read_body
    airport2 = JSON.parse(airport_response2)

    airport2["data"][0]["airportCode"]

  end


  def create_flight(source_code, destination_code, date)
    # this is just a comment
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchFlights?sourceAirportCode=#{source_code}&destinationAirportCode=#{destination_code}&date=#{date}&itineraryType=ONE_WAY&sortOrder=PRICE&numAdults=1&numSeniors=0&classOfService=ECONOMY&pageNumber=1&currencyCode=USD")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'b4b3100277mshe0370ca0aea55ddp14b73bjsn4164eba75913'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    flight_response = http.request(request).read_body
    flights = JSON.parse(flight_response)

    flights["data"]["flights"].first(10).map do |flight|
      {
        departure: flight["segments"][0]["legs"][0]["departureDateTime"],
        depart_location: flight["segments"][0]["legs"][0]["originStationCode"],
        arrival: flight["segments"][0]["legs"][0]["arrivalDateTime"],
        arrival_location: flight["segments"][0]["legs"][0]["destinationStationCode"],
        price_per_passenger: flight["purchaseLinks"][0]["totalPricePerPassenger"]
      }
    end
  end
end
