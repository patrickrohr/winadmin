class AddNewNumberToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :number, :integer
  end
end
