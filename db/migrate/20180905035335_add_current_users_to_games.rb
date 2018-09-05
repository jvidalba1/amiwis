class AddCurrentUsersToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :current_users, :integer
  end
end
