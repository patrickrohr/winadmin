class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.integer :number_of_sets

      t.timestamps
    end
  end
end
