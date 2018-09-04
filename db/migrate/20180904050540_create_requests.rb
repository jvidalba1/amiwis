class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true
      t.datetime :request_date
      t.timestamps
    end
  end
end
