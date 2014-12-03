class DeleteColumnQueueOfVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :queue_id
  end
end
