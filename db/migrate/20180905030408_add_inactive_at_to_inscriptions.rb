class AddInactiveAtToInscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :inscriptions, :inactive_at, :datetime
  end
end
