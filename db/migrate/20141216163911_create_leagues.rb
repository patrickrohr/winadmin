class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.integer :number
      t.integer :sport_id

      t.timestamps
    end
  end
end
