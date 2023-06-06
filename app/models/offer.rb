class Offer < ApplicationRecord
  belongs_to :user
  has_many :hotels
  has_many :flights
end
