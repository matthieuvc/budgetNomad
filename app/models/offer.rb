class Offer < ApplicationRecord
  belongs_to :user
  has_one :hotel
  has_one :flight

  geocoded_by :destination
  after_validation :destination, if: :will_save_change_to_address?
end
