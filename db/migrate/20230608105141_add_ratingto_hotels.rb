class AddRatingtoHotels < ActiveRecord::Migration[7.0]
  def change
    add_column :hotels, :rating, :integer
  end
end
