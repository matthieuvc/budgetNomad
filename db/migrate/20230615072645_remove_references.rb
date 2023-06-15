class RemoveReferences < ActiveRecord::Migration[7.0]
  def change
    remove_reference :packaging_activities, :offer
    add_reference :offers, :packaging_activity, foreign_key: true
  end
end
