class AddGamedayIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :gameday_id, :integer
  end
end
