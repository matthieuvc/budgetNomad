class PackagingActivitiesController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index


      #   if params[:query].present?
      #   sql_subquery = <<~SQL
      #     activities.category @@ :query
      #     OR activities.activity1 @@ :query
      #     OR activities.activity2 @@ :query
      #     OR activities.activity3 @@ :query
      #     OR activities.activity4 @@ :query
      #     SQL
      #     @activity_data = PackagingActivity.where(sql_subquery, query: params[:query])
      #   else
      #     @activity_data = PackagingActivity.all
      # end
    @offer = Offer.find(params[:offer_id])
    @hotel = Hotel.find(params[:hotel_id])
    @num_nights = @hotel.num_nights
    @activity_data = [
      {
        category: "Ultimate Nightlife",
        activity1: "Saga Ibiza Boat - Ultimate Party Cruise Adventure",
        activity2: "Pacha Ibiza - Iconic Nightlife Extravaganza",
        activity3: "Amnesia Ibiza - Unleash Your Party Spirit",
        activity4: "Ushuia Ibiza - Unforgettable Beachfront Party Paradise",
        city: "Ibiza",
        rating: 5,
        description: "Enjoy a fantastic boat party experience with live music, dancing, and breathtaking views of Ibiza's coastline.",
        price: 50,
        picture:"nigh.png"
      },
      {
        category: "Ultimate Nightlife",
        activity1: "Sun, sand, and lively parties at Ocean Beach.",
        activity2: "Non-stop dancing to infectious beats at Hï Ibiza.",
        activity3: "Awe-inspiring dancefloor at the iconic Privilege Ibiza",
        activity4: "Underground music paradise found at DC-10.",
        city: "Ibiza",
        rating: 4,
        description: "Experience the vibrant nightlife of Ibiza at renowned clubs, offering world-class DJs, energetic atmosphere, and unforgettable parties.",
        price: 60,
        picture:"nigh.png"
      },
      {
        category: "Ultimate Nightlife",
        activity1: "Breathtaking sunsets and vibrant nightlife on Sunset Strip.",
        activity2: "Unforgettable moments at Café Mambo, sipping cocktails and enjoying music.",
        activity3: "Immersive and enchanting experiences await at Es Paradis",
        activity4: "Unleash your party spirit at the legendary Eden Ibiza.",
        city: "Ibiza",
        rating: 4,
        description: "Immerse yourself in the magical sunset vibes of Ibiza's famous Sunset Strip, featuring iconic bars, stunning views, and chill-out music.",
        price: 40,
        picture:"nigh.png"
      },
      {
        category: "Thrilling Adventures",
        activity1: "Kayaking in Ibiza's Coves",
        activity2: "Rock Climbing in Sa Talaia",
        activity3: "Mountain Biking in Ibiza's Trails",
        activity4: "Coasteering in Ibiza's Coastline",
        city: "Ibiza",
        rating: 4,
        description: "Embark on thrilling adventures in Ibiza's natural landscapes, from kayaking through stunning coves to rock climbing and mountain biking in picturesque trails.",
        price: 80,
        picture:"adventure1.png"
      },
      {
        category: "Thrilling Adventures",
        activity1: "Scuba Diving in Ibiza's Marine Reserve",
        activity2: "Paragliding over Ibiza's Coast",
        activity3: "Jet Skiing in the Mediterranean",
        activity4: "Hiking to Es Vedrà",
        city: "Ibiza",
        rating: 4,
        description: "Experience adrenaline-pumping adventure activities in Ibiza, including scuba diving in the marine reserve, paragliding with breathtaking views, jet skiing in the crystal-clear waters, and hiking to the iconic Es Vedrà.",
        price: 120,
        picture:"adventure1.png"
      },
      {
        category: "Thrilling Adventures",
        activity1: "Yoga and Meditation Retreat in Ibiza",
        activity2: "Wellness and Spa Retreat in Ibiza",
        activity3: "Mindfulness Retreat in Ibiza's Nature",
        activity4: "Fitness and Detox Retreat in Ibiza",
        city: "Ibiza",
        rating: 4,
        description: "Indulge in rejuvenating retreat experiences in Ibiza, where you can immerse yourself in yoga and meditation, pamper with wellness treatments and spa therapies, practice mindfulness amidst nature, or focus on fitness and detoxification.",
        price: 150,
        picture:"Tranquil.png"
      },
      {
        category: "Relaxation and Rejuvenation",
        activity1: "Holistic Healing Retreat in Ibiza",
        activity2: "Art and Creativity Retreat in Ibiza",
        activity3: "Transformational Retreat in Ibiza's Sacred Sites",
        activity4: "Spiritual Retreat in Ibiza",
        city: "Ibiza",
        rating: 4,
        description: "Embark on transformative retreats in Ibiza, where you can experience holistic healing modalities, unleash your creativity through art workshops, explore the island's sacred sites for personal growth, or engage in spiritual practices for inner peace and awakening.",
        price: 200,
        picture:"Tranquil.png"
      },
      {
        category: "Culinary Extravaganza",
        activity1: "Ibiza Gourmet Food Tour",
        activity2: "Cooking Classes with Local Chefs",
        activity3: "Wine Tasting and Vineyard Tour",
        activity4: "Farm-to-Table Dining Experience",
        city: "Ibiza",
        rating: 4,
        description: "Immerse yourself in the culinary delights of Ibiza with a variety of gastronomic experiences. Indulge in a gourmet food tour to savor the local cuisine, learn the art of cooking from expert chefs in cooking classes, embark on a wine tasting journey and vineyard tour, or enjoy a farm-to-table dining experience showcasing the freshest local ingredients.",
        price: 80,
        picture:"paella.png"
      },
      {
        category: "Culinary Extravaganza",
        activity1: "Ibiza Food and Wine Tasting Tour",
        activity2: "Cooking Classes with Local Chefs",
        activity3: "Farm-to-Table Dining Experience",
        activity4: "Gastronomic Walking Tour of Ibiza Town",
        city: "Ibiza",
        rating: 4,
        description: "Immerse yourself in the culinary delights of Ibiza with a range of gastronomic experiences. Take a food and wine tasting tour to sample local delicacies and wines, learn the art of cooking from skilled local chefs in interactive cooking classes, enjoy a farm-to-table dining experience with fresh and organic ingredients, and explore the flavors of Ibiza on a gastronomic walking tour through Ibiza Town.",
        price: 100,
        picture:"paella.png"
      },
      {
        category: "Culinary Extravaganza",
        activity1: "Seafood Cooking Workshop",
        activity2: "Ibiza Paella Masterclass",
        activity3: "Tapas Tasting and Wine Pairing",
        activity4: "Cheese and Wine Pairing Experience",
        city: "Ibiza",
        rating: 4,
        description: "Delve into the culinary traditions of Ibiza with hands-on culinary workshops and tastings. Learn the secrets of preparing seafood dishes in a cooking workshop, master the art of making authentic Ibiza paella in a dedicated masterclass, indulge in a tapas tasting experience with perfectly paired wines, and explore the world of cheese and wine pairing in a dedicated session.",
        price: 80,
        picture:"paella.png"
      },
      {
        category: "Relaxation and Rejuvenation",
        activity1: "Yoga and Meditation Retreat in Nature",
        activity2: "Spa and Wellness Retreat",
        activity3: "Holistic Healing Workshops",
        activity4: "Mindfulness and Stress Management Retreat",
        city: "Ibiza",
        rating: 4,
        description: "Immerse yourself in a wellness retreat in Ibiza, where you can rejuvenate your mind, body, and soul. Experience a tranquil yoga and meditation retreat amidst nature's beauty, indulge in luxurious spa treatments and wellness therapies, participate in holistic healing workshops to nurture your well-being, or join a mindfulness and stress management retreat to find inner peace and balance.",
        price: 120,
        picture:"Tranquil.png"
      },
      {
        category: "Creativity and Art Inspiration",
        activity1: "Street Art Tour and Graffiti Workshop",
        activity2: "Painting and Wine Tasting Experience",
        activity3: "Artistic Photography Tour",
        activity4: "Sculpture Making Workshop",
        city: "Ibiza",
        rating: 4,
        description: "Embark on an artistic immersion in Ibiza, where you can explore and express your creativity. Take a street art tour to discover vibrant murals and participate in a graffiti workshop to create your own urban art. Engage in a painting session while enjoying a wine tasting experience. Join an artistic photography tour to capture the beauty of Ibiza through your lens. Unleash your sculpting skills in a hands-on sculpture making workshop.",
        price: 90,
        picture:"art.png"
      }
    ]
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
