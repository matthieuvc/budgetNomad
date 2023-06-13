class AddReturnOutboundInFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :return_outbound, :datetime
  end
end
