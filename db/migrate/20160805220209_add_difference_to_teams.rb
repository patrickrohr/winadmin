class AddDifferenceToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :difference, :integer
  end
end
