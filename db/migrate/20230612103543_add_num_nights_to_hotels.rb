class AddNumNightsToHotels < ActiveRecord::Migration[7.0]
  def change
    add_column :hotels, :num_nights, :integer
  end
end
