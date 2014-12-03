class AddMyqueuesIdColumnToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :myqueue_id, :integer
  end
end
