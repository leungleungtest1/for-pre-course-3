class ReviewsController < ApplicationController
  before_action :require_log_in
  def create
    @video = Video.find(params[:video_id])
    @review = Review.create( params.require(:review).permit!)
    @review.video = @video
    @review.user = current_user
    @review.save
    if @review.valid?
    flash.now[:success] = "Your review is posted"
    render "videos/show"
    else
    flash[:error] = "#{@review.errors.full_messages.join(" ")}"
    redirect_to video_path(@video)
    end
  end
end