class RemoveMaxBudgetFromOffers < ActiveRecord::Migration[7.0]
  def change
    remove_column :offers, :max_budget, :float
  end
end
