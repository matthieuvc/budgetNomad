class Offer < ApplicationRecord
  belongs_to :user
  has_one :hotel
  has_many :flights

  geocoded_by :destination
  # after_validation :geocode, if: :will_save_change_to_destination?
end
