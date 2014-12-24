class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :team_1_id
      t.integer :team_2_id
      t.integer :winner_id
      t.boolean :tie

      t.timestamps
    end
  end
end
