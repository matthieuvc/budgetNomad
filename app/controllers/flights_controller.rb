class FlightsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    airport_code = source_airport_code
    create_flight(airport_code)
  end

  private

  def flight_params
    params.require(:flight).permit(:localisation, :destination, :budget, :start_date, :end_date)
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


  def create_flight(airport_code)
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchFlights?sourceAirportCode=#{airport_code}&destinationAirportCode=#{destination_airport_code}&date=#{date}itineraryType=%3CREQUIRED%3E&sortOrder=%3CREQUIRED%3E&numAdults=1&numSeniors=0&classOfService=%3CREQUIRED%3E&pageNumber=1&currencyCode=USD")

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
