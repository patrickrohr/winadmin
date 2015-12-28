class RemoveOrderFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :order
  end
end
