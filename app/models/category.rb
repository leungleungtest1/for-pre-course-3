class Category < ActiveRecord::Base
  has_many :videos, -> {order 'title asc'}
  validates :name, uniqueness: true
  validates :name, presence: true
  def recent_videos
    self.videos.order("created_at DESC").first(6)
  end
end