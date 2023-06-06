class OffersController < ApplicationController
  def show
    @offer = Offer.find(params[:id])
  end

  def index
    @offers = Offer.all
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

  private

  def offer_params
    params.require(:offer).permit(:destination, :budget, :start_date, :end_date)
  end
end
