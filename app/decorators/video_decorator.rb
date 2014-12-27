class VideoDecorator < Draper::Decorator
  delegate_all
  def average_rating
    total_rating = 0.0
    object.reviews.each do |review|
      total_rating += review.rating 
    end
    if self.reviews.count >0
      (total_rating/(self.reviews.count)).round(1)
    else
      0
    end
  end

  def show_rate_in_template
    "Rate: "+ object.average_rating.to_s
  end
end