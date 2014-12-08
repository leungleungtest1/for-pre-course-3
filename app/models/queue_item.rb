class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  before_save :assign_postion
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :position, {only_integer: true}

  def rating
    review = Review.where(user: user.id, video: video).first
    if review
      review.rating
    end
  end
  def category_name
    if category
      self.category.name
    end
  end

private
  
  def assign_postion
    if self.position == nil
      self.position = self.id
    end
  end
end