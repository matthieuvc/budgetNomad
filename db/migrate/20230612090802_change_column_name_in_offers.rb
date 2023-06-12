class ChangeColumnNameInOffers < ActiveRecord::Migration[7.0]
  def change
    rename_column :offers, :min_budget, :budget
  end
end
