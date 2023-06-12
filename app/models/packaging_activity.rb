class PackagingActivity < ApplicationRecord
  belongs_to :offer
  has_one_attached :picture
end
