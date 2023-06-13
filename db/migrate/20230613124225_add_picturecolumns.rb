class AddPicturecolumns < ActiveRecord::Migration[7.0]
  def change
    add_column :hotels, :picture, :string
  end
end
