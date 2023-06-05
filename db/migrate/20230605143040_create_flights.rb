class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.float :price
      t.datetime :departure
      t.datetime :arrival

      t.timestamps
    end
  end
end
