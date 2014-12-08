class Video < ActiveRecord::Base
  has_many :reviews,->{order "created_at desc"}
  has_many :queueitems
  has_many :myqueues, through: :myqueuevideos
  belongs_to :category
  validates :title, :description, presence: true

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    self.where("title iLIKE ?", "%#{search_term}%").order("created_at DESC")
  end
  def average_rating
    total_rating = 0.0
    self.reviews.each do |review|
      total_rating += review.rating 
    end
    if self.reviews.count >0
    (total_rating/(self.reviews.count)).round(1)
  else
    0
  end
  end
end