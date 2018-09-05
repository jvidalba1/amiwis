class AddPlaceToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :place, :string
  end
end
