class RenameTypeColumnInPackagingActivity < ActiveRecord::Migration[7.0]
  def change
    rename_column :packaging_activities, :type, :category
  end
end
