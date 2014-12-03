class DeleteColumnMyqueueOfVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :myqueue_id
  end
end
