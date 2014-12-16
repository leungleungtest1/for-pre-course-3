module ApplicationHelper

  def options_for_video_reviews(default_value=nil)
    options_for_select([['1 Star',1],['2 Stars',2],['3 Stars',3],['4 Stars',4],['5 Stars',5]],default_value)
  end
end
