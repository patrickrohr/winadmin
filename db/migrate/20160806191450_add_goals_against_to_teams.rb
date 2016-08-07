class AddGoalsAgainstToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :goals_against, :integer
  end
end
