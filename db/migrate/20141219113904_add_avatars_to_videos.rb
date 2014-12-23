class AddAvatarsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :avatars, :json
  end
end
