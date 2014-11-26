class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :description, :url_small_cover, :url_large_cover

      t.timestamp
    end
  end
end
