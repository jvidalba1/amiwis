class AddPosition2ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :position2, :integer
  end
end
