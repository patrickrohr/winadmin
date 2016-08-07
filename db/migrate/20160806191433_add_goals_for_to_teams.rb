class AddGoalsForToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :goals_for, :integer
  end
end
