class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :match_date
      t.belongs_to :group
      t.timestamps
    end
  end
end
