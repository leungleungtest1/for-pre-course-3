class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  before_save :assign_postion
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :position, {only_integer: true}

  def rating
    find_the_review
    if @review
      @review.rating
    end
  end

  def rating=(new_rating)
    find_the_review
    if @review
      @review.update_column(:rating, new_rating)
    else
      @review=Review.create(user: user, video:video, rating: new_rating)
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

  def find_the_review
    @review ||= Review.where(user: user, video: video).first
  end
end