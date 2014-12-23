class RemoveColumnVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :avatars
  end
end
