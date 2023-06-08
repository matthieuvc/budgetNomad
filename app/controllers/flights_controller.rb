class FlightsController < ApplicationController

  def index
    @offer = Offer.last
    @flight_data =  [{:departure_time=>"2023-06-07T20:10:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T22:40:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>60.2}, {:departure_time=>"2023-06-07T15:45:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T17:55:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>67.52}, {:departure_time=>"2023-06-07T21:00:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T23:10:00+05:30", :arrival_location=>"DEL", :price_per_passenger=>69}, {:departure_time=>"2023-06-07T22:35:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-07T23:45:00+05:30", :arrival_location=>"GOI", :price_per_passenger=>113.44}, {:departure_time=>"2023-06-07T22:05:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-08T00:55:00+05:30", :arrival_location=>"ATQ", :price_per_passenger=>123.97}, {:departure_time=>"2023-06-07T23:25:00+05:30", :depart_location=>"BOM", :arrival_time=>"2023-06-08T07:25:00+08:00", :arrival_location=>"KUL", :price_per_passenger=>657.45}]
  end

  def new
    @flight = Flight.new
  end

  def create
    flight_details = {
      departure: flight_params["departure_time"].to_datetime,
      arrival: flight_params["arrival_time"].to_datetime,
      price: flight_params["price_per_passenger"].to_f,
      offer: Offer.last
    }
    @flight = Flight.new(flight_details)
    @flight.save
    redirect_to hotels_path
  end


  private

  def flight_params
    params.require(:flight).permit(:arrival_location, :arrival_time, :depart_location, :departure_time, :price_per_passenger)
  end
end
