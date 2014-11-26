class Video < ActiveRecord::Base
  validates :title, uniqueness: true
end