class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @offer = Offer.new
    @offers = Offer.all
    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { offer: offer })
      }
    end
  end

  def dashboard
    @offers = current_user.offers
  end
end
