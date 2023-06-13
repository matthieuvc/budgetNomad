class RenameDepartureInFlights < ActiveRecord::Migration[7.0]
  def change
    rename_column :flights, :departure, :departure_outbound
  end
end
