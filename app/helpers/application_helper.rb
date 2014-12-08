module ApplicationHelper

  def options_for_video_reviews(default_value=nil)
    options_for_select([['1 star',1],['2 stars',2],['3 stars',3],['4 stars',4],['5 stars',5]],default_value)
  end
end
