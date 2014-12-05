class QueueItemsController < ApplicationController
before_action :require_log_in
  def index
    @queue_items = current_user.queue_items      
  end
  def create
    user = User.find session[:user_id]
    video = Video.find params[:video_id]
    queue_the_video(user,video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find params[:id]
    if queue_item.user == current_user
      QueueItem.delete params[:id]
    end
    redirect_to my_queue_path
  end

  private
    def postion_queue_item(user)
        user.queue_items.count+1      
    end
    def queue_the_video(user,video)
      if  user_not_add_video_to_queue(user, video) == 0
      @queue_item = QueueItem.create(user: user, video: video, position: postion_queue_item(user))
      end
    end
    def user_not_add_video_to_queue(user, video)
      user.queue_items.where(video_id: video.id).count
    end
end