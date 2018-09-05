class CreateInscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :inscriptions do |t|
      t.belongs_to :game, index: true
      t.belongs_to :user, index: true
      t.datetime :incription_date
      t.timestamps
    end
  end
end
