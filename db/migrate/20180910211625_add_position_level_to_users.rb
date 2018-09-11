class AddPositionLevelToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :position, :integer
    add_column :users, :level, :integer
  end
end
