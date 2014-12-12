class User < ActiveRecord::Base
has_many :reviews, -> {order 'created_at desc'}
has_secure_password validations: false
validates :name, presence: true
validates :password, presence: true, length: {minimum: 4}
validates :email, uniqueness: true
has_many :queue_items,-> { order 'position asc'}
has_many :followerships, class_name: "Relationship", foreign_key: "follower_id"
has_many :leaders, through: :followerships
has_many :leaderships, class_name: "Relationship", foreign_key: "leader_id"
has_many :followers, through: :leaderships
    def nomalize_queue_items_position
      queue_items.each_with_index do |q_item, index|
      q_item.update_attributes(position: index+1)
      end
    end

    def postion_queue_item
        self.queue_items.count+1      
    end

    def not_add_video_to_queue(video)
      queue_items.where(video_id: video.id).count
    end
    def have_queued_video?(video)
      QueueItem.where(user_id: self.id, video_id: video.id).empty?
    end
    def follow?(leader)
      leaders.include?(leader)
    end
end 