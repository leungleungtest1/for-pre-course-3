class Myqueuevideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :myqueue
end