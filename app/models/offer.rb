class Offer < ApplicationRecord
  belongs_to :user
  has_one :hotel
  has_one :flight

  geocoded_by :destination
end
