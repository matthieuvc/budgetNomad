class AddDepartLocationToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :depart_location, :string
    add_column :flights, :arrival_location, :string
  end
end
