class Offer < ApplicationRecord
  belongs_to :user
  has_one :hotel
  has_one :flight
  has_one :packaging_activity

  geocoded_by :destination
end
