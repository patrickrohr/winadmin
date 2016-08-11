class AddDeletedAtToGamesets < ActiveRecord::Migration
  def change
    add_column :gamesets, :deleted_at, :datetime
    add_index :gamesets, :deleted_at
  end
end
