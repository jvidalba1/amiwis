class AddReplyAtToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :reply_at, :datetime
  end
end
