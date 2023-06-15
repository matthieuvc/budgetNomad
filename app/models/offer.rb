class Offer < ApplicationRecord
  belongs_to :user
  has_one :hotel
  has_many :flights
  belongs_to :packaging_activity, optional: true
  geocoded_by :destination
  validates :budget, presence: true
  validates :budget, :numericality => { :greater_than => 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_comparison_of :end_date, greater_than: :start_date, other_than: Date.today

  validates :destination, presence: true
  validates :localisation, presence: true
end
