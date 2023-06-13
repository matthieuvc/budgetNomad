class AddLongitudeToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :longitude, :float
    add_column :offers, :latitude, :float
  end
end
