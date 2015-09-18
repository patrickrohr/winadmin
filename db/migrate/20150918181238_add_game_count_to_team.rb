class AddGameCountToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :game_count, :integer
  end
end
