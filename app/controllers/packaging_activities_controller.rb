class PackagingActivitiesController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
  if params[:query].present?
    sql_subquery = <<~SQL
    category @@ :query
    OR description @@ :query
    OR city @@ :query
    OR activity1 @@ :query
    OR activity2 @@ :query
    OR activity3 @@ :query
    OR activity4 @@ :query
    SQL
    @activity_data = PackagingActivity.where(sql_subquery, query: params[:query])
    else
      @activity_data = PackagingActivity.all
    end
  @offer = Offer.find(params[:offer_id])
  @hotel = Hotel.find(params[:hotel_id])
  @num_nights = @hotel.num_nights
  @activity_data.shuffle
  end

  def new
    @packaging_activities = PackagingActivity.new
  end

  def create
    @packaging_activity = PackagingActivity.find(params[:packaging_activities])
    @offer = Offer.find(params[:offer_id])
    @offer.packaging_activity = @packaging_activity
    @offer.save
    redirect_to offer_path(@offer)
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
