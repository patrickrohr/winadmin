class CreateGamedays < ActiveRecord::Migration
  def change
    create_table :gamedays do |t|
      t.date :date
      t.string :location
      t.string :league_id

      t.timestamps
    end
  end
end
