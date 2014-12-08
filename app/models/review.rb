class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates :rating, presence: true, numericality:{only_integer: true}

  validates :user_id, presence: true
  validates :video_id, presence: true
end