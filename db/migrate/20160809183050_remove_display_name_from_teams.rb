class RemoveDisplayNameFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :display_name, :string
  end
end
