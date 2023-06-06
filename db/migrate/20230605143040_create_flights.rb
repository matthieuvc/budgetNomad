class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.float :price
      t.datetime :departure
      t.datetime :arrival
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
