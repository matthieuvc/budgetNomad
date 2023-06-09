class AddLocalisationtoOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :localisation, :string
    add_column :offers, :max_budget, :float
    rename_column :offers, :budget, :min_budget
  end
end
