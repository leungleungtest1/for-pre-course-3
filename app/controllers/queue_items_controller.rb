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
    current_user.nomalize_queue_items_position
    redirect_to my_queue_path
  end

  def update_queue
    begin
      #update_queue_rating 
      update_queue_items
    rescue ActiveRecord::RecordInvalid
            flash[:error] = "something wrong in your queue"
            redirect_to my_queue_path
            return
    end
    current_user.nomalize_queue_items_position
    redirect_to my_queue_path
  end

  private

    def queue_the_video(user,video)
      if  user.not_add_video_to_queue(video) == 0
      @queue_item = QueueItem.create(user: user, video: video, position: user.postion_queue_item )
      end
    end

    def update_queue_items
      ActiveRecord::Base.transaction do
        params[:queue_item].each do |element|
          q_item =  QueueItem.find element[:id]
          q_item.update_attributes!(position: element[:position],rating: element[:rating]) if q_item.user == current_user
        end
      end
    end

    #def update_queue_rating
      #ActiveRecord::Base.transaction do
        #params[:queue_item].each do |element|
          #q_item = QueueItem.find element[:id]
          #review = Review.where(user_id: session[:user_id], video_id: q_item.video_id).first
          #if review.nil?
            #review = Review.create(user_id: session[:user_id],video_id: q_item.video_id, rating: element[:rating])
          #end
          #review.update_attributes!(rating: element[:rating])
        #end
      #end
    #end
end