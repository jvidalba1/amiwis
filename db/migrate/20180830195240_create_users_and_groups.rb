class CreateUsersAndGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    create_table :users_groups, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
    end
  end
end
