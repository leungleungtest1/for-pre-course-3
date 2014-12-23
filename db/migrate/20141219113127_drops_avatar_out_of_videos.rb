class DropsAvatarOutOfVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :avatar
  end
end
