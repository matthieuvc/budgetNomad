class FlightsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @offer = Offer.find(params[:offer])
    flights = fetch_flights
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
      arrival_location: flight_params["arrival_location"],
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
        arrival_location: flight_params["arrival_location"],
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
    request["X-RapidAPI-Key"] = '503a48dfecmsh69c31a138b3f12dp189e0bjsn731e815fb930'
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
    request["X-RapidAPI-Key"] = '503a48dfecmsh69c31a138b3f12dp189e0bjsn731e815fb930'
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
    request["X-RapidAPI-Key"] = '503a48dfecmsh69c31a138b3f12dp189e0bjsn731e815fb930'
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
