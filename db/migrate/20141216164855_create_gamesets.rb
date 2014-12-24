class CreateGamesets < ActiveRecord::Migration
  def change
    create_table :gamesets do |t|
      t.integer :game_id
      t.integer :number
      t.integer :points_team_1
      t.integer :points_team_2

      t.timestamps
    end
  end
end
