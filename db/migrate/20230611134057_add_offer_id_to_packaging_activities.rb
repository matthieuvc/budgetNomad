class AddOfferIdToPackagingActivities < ActiveRecord::Migration[7.0]
  def change
    add_reference :packaging_activities, :offer, null: false, foreign_key: true
  end
end
