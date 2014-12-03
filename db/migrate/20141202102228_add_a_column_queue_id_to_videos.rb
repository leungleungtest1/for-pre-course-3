class AddAColumnQueueIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :queue_id, :integer
  end
end
