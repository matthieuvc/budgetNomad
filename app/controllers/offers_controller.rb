class OffersController < ApplicationController
  def index
    @offer = Offer.new
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
    @flight = @offer.flight
    @hotel = @offer.hotel
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user

    @offer.save
    redirect_to offer_path(@offer)
  end

  # def update (WILL ONLY BE USED WHEN WE APPLY CATEGORIES)
  #   @offer = Offer.find(params[:id])
  #   @offer.update(offer_params)

  #   redirect_to offer_path(@offer)
  # end

  def offer_params
    params.require(:offer).permit(:localisation, :destination, :budget, :start_date, :end_date)
  end
end
