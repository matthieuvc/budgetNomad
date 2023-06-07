class FlightsController < ApplicationController

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(flight_params)
    @offer.save
  end

  def flight_params
    params.require(:flight).permit(:price, :departure, :arrival)
  end
end
