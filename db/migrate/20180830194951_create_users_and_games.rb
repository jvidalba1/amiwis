class CreateUsersAndGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :game_date
      t.belongs_to :group
      t.timestamps
    end

    create_table :games_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true
    end
  end
end
