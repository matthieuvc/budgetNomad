class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.float :price
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
