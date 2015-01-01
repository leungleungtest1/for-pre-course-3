class AddYoutubeUrlToVideos < ActiveRecord::Migration
  def change
  add_column :videos, :youtube_url, :string
  end
end
