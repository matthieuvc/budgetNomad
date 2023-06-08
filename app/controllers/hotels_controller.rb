class HotelsController < ApplicationController

  def index
    @offer = Offer.last
    @hotel_data = [{:hotel_title=>"1. Homewood Suites by Hilton New York/Midtown Manhattan Times Square-South, NY", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/74/3b/fe/exterior.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"2. Hampton Inn Manhattan / Times Square Central", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/7f/cb/1f/exterior.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"3. Ace Hotel Brooklyn", :hotel_rating=>5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1d/88/65/31/the-lobby-at-ace-hotel.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"4. Pod 51 Hotel", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/28/9d/6c/d4/pod-roof.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"5. Opera House Hotel", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/7f/46/ba/superior-king--v12464873.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"6. Truss Hotel Times Square", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/23/c3/b0/bf/truss-hotel.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"7. Crowne Plaza Times Square Manhattan, an IHG Hotel", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/0e/d2/62/the-crowne-plaza-times.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"8. YOTEL New York Times Square", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/99/35/6e/yotel-new-york-entrance.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"9. Envue, Autograph Collection", :hotel_rating=>4.5, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/37/c1/85/nohu-rooftop-bar-restaurant.jpg?w={width}&h={height}&s=1"}, {:hotel_title=>"10. Hampton Inn New York - LaGuardia Airport", :hotel_rating=>4, :hotel_picture=>"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/79/a7/11/exterior.jpg?w={width}&h={height}&s=1"}]
  end

  def new
    @hotel = Hotel.new
  end

  def create
    hotel_details = {
      #add price and adress
      name: hotel_params["hotel_title"].to_s,
      offer: Offer.last
    }
    @hotel = Hotel.new(hotel_details)
    @hotel.save
    redirect_to offer_path(@hotel.offer)

  end

  def hotel_params
    params.require(:hotel).permit(:hotel_title, :hotel_rating, :hotel_picture)
  end
end
