class RemoveDifferenceFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :difference, :integer
  end
end
