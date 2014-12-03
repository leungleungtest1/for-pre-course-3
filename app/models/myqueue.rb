class Myqueue < ActiveRecord::Base
  belongs_to :user
  has_many :myqueuevideos
  has_many :videos, through: :myqueuevideos
  validates :user_id, presence: :true
end