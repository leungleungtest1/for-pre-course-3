class Category < ActiveRecord::Base
  has_many :videos, -> {order('title ASC')}
  validates :name, uniqueness: true
  def recent_videos
    self.videos.order("created_at DESC").first(6)
  end
end