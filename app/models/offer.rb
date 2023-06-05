class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :hotel
  belongs_to :flight
end
