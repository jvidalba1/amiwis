class CreateTeamsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :identify

      t.timestamps
    end

    create_table :teams_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true
    end
  end
end
