class OffersController < ApplicationController
  # def show

  # end

  def index
    @offers = Offer.all
  end

  # def create
  #   @offer = Offer.new(offer_params)

  #   @offer.save
  #   redirect_to
  # end

  # def update

  # end

  # private

  # def offer_params
  #   params.require(:offer).permit(:)
  # end
end
