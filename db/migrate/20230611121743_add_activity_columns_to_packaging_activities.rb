class AddActivityColumnsToPackagingActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :packaging_activities, :activity1, :string
    add_column :packaging_activities, :activity2, :string
    add_column :packaging_activities, :activity3, :string
    add_column :packaging_activities, :activity4, :string
  end
end
