class RemoveAvatarOfVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :avatar
  end
end
