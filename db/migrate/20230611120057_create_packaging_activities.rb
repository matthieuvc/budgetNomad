class CreatePackagingActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :packaging_activities do |t|
      t.string :type
      t.integer :rating
      t.text :description
      t.string :city
      t.integer :price
      t.string :picture

      t.timestamps
    end
  end
end
