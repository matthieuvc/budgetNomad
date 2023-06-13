class RenameArrivalInFlights < ActiveRecord::Migration[7.0]
  def change
    rename_column :flights, :arrival, :departure_inbound
  end
end
