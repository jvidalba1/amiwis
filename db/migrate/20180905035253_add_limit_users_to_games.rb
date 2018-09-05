class AddLimitUsersToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :limit_users, :integer
  end
end
