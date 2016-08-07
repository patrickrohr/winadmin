class AddGoalsDifferenceToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :goals_difference, :integer
  end
end
