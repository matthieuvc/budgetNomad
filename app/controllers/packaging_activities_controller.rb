class PackagingActivitiesController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
  if params[:query].present?
    sql_subquery = <<~SQL
    activities.category @@ :query
    OR activities.activity1 @@ :query
    OR activities.activity2 @@ :query
    OR activities.activity3 @@ :query
    OR activities.activity4 @@ :query
    SQL
    @activity_data = PackagingActivity.where(sql_subquery, query: params[:query])
    else
      @activity_data = PackagingActivity.all
    end
  @offer = Offer.find(params[:offer_id])
  @hotel = Hotel.find(params[:hotel_id])
  @num_nights = @hotel.num_nights
  @activity_data.shuffle!
  end

  def new
    @packaging_activities = PackagingActivity.new
  end

  def create
    package_details = {
      category: packaging_activities_params["category"],
      activity1: packaging_activities_params["activity1"],
      activity2: packaging_activities_params["activity2"],
      activity3: packaging_activities_params["activity3"],
      activity4: packaging_activities_params["activity4"],
      price: packaging_activities_params["price"],
      city: packaging_activities_params["city"],
      rating: packaging_activities_params["rating"],
      description: packaging_activities_params["description"],
      picture: packaging_activities_params["picture"]
    }
    @packaging_activities = PackagingActivity.new(package_details)
    @offer = Offer.find(params[:offer_id])
    @packaging_activities.offer = @offer
    @packaging_activities.save
    redirect_to offer_path(@packaging_activities.offer)
  end

  private

  def packaging_activities_params
    params.require(:packaging_activities).permit(
      :category,
      :rating,
      :description,
      :city,
      :price,
      :picture,
      :activity1,
      :activity2,
      :activity3,
      :activity4,
      :offer_id
    )
  end
end
