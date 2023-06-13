class AddReturnInboundInFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :return_inbound, :datetime
  end
end
