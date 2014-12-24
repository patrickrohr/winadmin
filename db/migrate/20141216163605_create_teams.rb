class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :display_name
      t.string :email
      t.integer :points
      t.integer :club_id
      t.integer :sport_id

      t.timestamps
    end
  end
end
