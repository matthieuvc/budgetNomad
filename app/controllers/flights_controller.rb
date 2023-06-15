class FlightsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @offer = Offer.find(params[:offer])
    #flights = fetch_flights
    flights = {:going=>[[{:departure=>"2023-06-15T22:25:00+02:00", :departure_location=>"BRU", :arrival=>"2023-06-16T00:35:00+02:00", :arrival_location=>"BCN", :price_per_passenger=>267.24}, {:departure=>"2023-06-16T07:10:00+02:00", :departure_location=>"BCN", :arrival=>"2023-06-16T08:15:00+02:00", :arrival_location=>"IBZ", :price_per_passenger=>267.24}], [{:departure=>"2023-06-15T22:25:00+02:00", :departure_location=>"BRU", :arrival=>"2023-06-16T00:35:00+02:00", :arrival_location=>"BCN", :price_per_passenger=>272.915}, {:departure=>"2023-06-16T07:10:00+02:00", :departure_location=>"BCN", :arrival=>"2023-06-16T08:15:00+02:00", :arrival_location=>"IBZ", :price_per_passenger=>272.915}], [{:departure=>"2023-06-15T22:25:00+02:00", :departure_location=>"BRU", :arrival=>"2023-06-16T00:35:00+02:00", :arrival_location=>"BCN", :price_per_passenger=>278.59}, {:departure=>"2023-06-16T08:45:00+02:00", :departure_location=>"BCN", :arrival=>"2023-06-16T09:50:00+02:00", :arrival_location=>"IBZ", :price_per_passenger=>278.59}], [{:departure=>"2023-06-15T15:05:00+02:00", :departure_location=>"BRU", :arrival=>"2023-06-15T16:00:00+02:00", :arrival_location=>"AMS", :price_per_passenger=>364.85}, {:departure=>"2023-06-15T19:50:00+02:00", :departure_location=>"AMS", :arrival=>"2023-06-15T22:25:00+02:00", :arrival_location=>"IBZ", :price_per_passenger=>364.85}]], :comming=>[[{:departure=>"2023-06-23T23:25:00+02:00", :departure_location=>"IBZ", :arrival=>"2023-06-24T00:25:00+02:00", :arrival_location=>"BCN", :price_per_passenger=>267.24}, {:departure=>"2023-06-24T06:50:00+02:00", :departure_location=>"BCN", :arrival=>"2023-06-24T09:05:00+02:00", :arrival_location=>"BRU", :price_per_passenger=>267.24}], [{:departure=>"2023-06-23T22:30:00+02:00", :departure_location=>"IBZ", :arrival=>"2023-06-23T23:30:00+02:00", :arrival_location=>"BCN", :price_per_passenger=>272.915}, {:departure=>"2023-06-24T06:50:00+02:00", :departure_location=>"BCN", :arrival=>"2023-06-24T09:05:00+02:00", :arrival_location=>"BRU", :price_per_passenger=>272.915}], [{:departure=>"2023-06-23T23:25:00+02:00", :departure_location=>"IBZ", :arrival=>"2023-06-24T00:25:00+02:00", :arrival_location=>"BCN", :price_per_passenger=>278.59}, {:departure=>"2023-06-24T06:50:00+02:00", :departure_location=>"BCN", :arrival=>"2023-06-24T09:05:00+02:00", :arrival_location=>"BRU", :price_per_passenger=>278.59}], [{:departure=>"2023-06-23T15:00:00+02:00", :departure_location=>"IBZ", :arrival=>"2023-06-23T16:15:00+02:00", :arrival_location=>"MAD", :price_per_passenger=>364.85}, {:departure=>"2023-06-23T17:10:00+02:00", :departure_location=>"MAD", :arrival=>"2023-06-23T19:50:00+02:00", :arrival_location=>"AMS", :price_per_passenger=>364.85}, {:departure=>"2023-06-23T21:35:00+02:00", :departure_location=>"AMS", :arrival=>"2023-06-23T22:20:00+02:00", :arrival_location=>"BRU", :price_per_passenger=>364.85}]]}
    @departure_data = flights[:going]
    @return_data = flights[:comming]
  end

  def new
    @flight = Flight.new
  end

  def create
    @offer = Offer.find(params[:offer])
    flight_params[:going].each do |flight|
    flight_details = {
      departure: flight["departure"].to_datetime,
      depart_location: flight["departure_location"],
      arrival: flight["arrival"].to_datetime,
      arrival_location: flight["arrival_location"],
      price: flight["price_per_passenger"].to_f
    }
    @flight = Flight.new(flight_details)
    @flight.offer = @offer
    @flight.save!
    end

    flight_params[:comming].each do |flight|
      flight_details = {
        departure: flight["departure"].to_datetime,
        depart_location: flight["departure_location"],
        arrival: flight["arrival"].to_datetime,
        arrival_location: flight["arrival_location"],
        price: flight["price_per_passenger"].to_f
      }
      @flight = Flight.new(flight_details)
      @flight.offer = @offer
      @flight.save!
      end

    redirect_to hotels_path(offer_id: @offer.id, flight_id: @flight.id)
  end

  private

  def flight_params
    params.require(:flight).permit(going: [:departure, :departure_location, :arrival, :arrival_location, :price_per_passenger], comming: [:departure, :departure_location, :arrival, :arrival_location, :price_per_passenger])
  end

  def source_airport_code
    localisation = @offer.localisation
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchAirport?query=#{localisation}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '1d9f5d7888msha32a10e846bf6f6p1f8d3bjsn911b18232b2e'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    airport_response1 = http.request(request).read_body
    airport = JSON.parse(airport_response1)

    return airport["data"][0]["airportCode"]
  end

  def destination_airport_code
    destination = @offer.destination
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchAirport?query=#{destination}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '1d9f5d7888msha32a10e846bf6f6p1f8d3bjsn911b18232b2e'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'

    airport_response2 = http.request(request).read_body
    airport2 = JSON.parse(airport_response2)

    return airport2["data"][0]["airportCode"]
  end

  def fetch_flights
    url = URI("https://tripadvisor16.p.rapidapi.com/api/v1/flights/searchFlights?sourceAirportCode=#{source_airport_code}&destinationAirportCode=#{destination_airport_code}&date=#{@offer.start_date}&itineraryType=ROUND_TRIP&sortOrder=PRICE&numAdults=1&numSeniors=0&classOfService=ECONOMY&returnDate=#{@offer.end_date}&pageNumber=1&currencyCode=USD")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '1d9f5d7888msha32a10e846bf6f6p1f8d3bjsn911b18232b2e'
    request["X-RapidAPI-Host"] = 'tripadvisor16.p.rapidapi.com'
    flight_response = http.request(request).read_body
    @flights = JSON.parse(flight_response)

    {going: fetch_departures, comming:    fetch_returns}
  end

  def fetch_departures
    departure_data = @flights["data"]["flights"].first(10).map do |a_flight|
        flights_array = a_flight["segments"][0]["legs"].map do |flight|
          {
            departure: flight["departureDateTime"],
            departure_location: flight["originStationCode"],
            arrival: flight["arrivalDateTime"],
            arrival_location: flight["destinationStationCode"],
            price_per_passenger: a_flight["purchaseLinks"].first["totalPrice"].fdiv(a_flight["segments"][0]["legs"].count)
          }
        end
        flights_array
    end
  end

  def fetch_returns
    return_data = @flights["data"]["flights"].first(10).map do |a_flight|
      flights_array = a_flight["segments"][1]["legs"].map do |flight|
        {
          departure: flight["departureDateTime"],
          departure_location: flight["originStationCode"],
          arrival: flight["arrivalDateTime"],
          arrival_location: flight["destinationStationCode"],
          price_per_passenger: a_flight["purchaseLinks"].first["totalPrice"].fdiv(a_flight["segments"][0]["legs"].count)
        }
      end
      flights_array
    end
  end
end
