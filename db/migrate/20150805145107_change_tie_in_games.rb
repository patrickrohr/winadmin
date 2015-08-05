class ChangeTieInGames < ActiveRecord::Migration
  def change
    change_column :games, :tie, :boolean, default: false
  end
end
