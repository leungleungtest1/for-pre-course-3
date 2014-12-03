class ReviewsController < ApplicationController
  before_action :require_log_in
  def create
    @video = Video.find(params[:video_id])
    @review = Review.create( params.require(:review).permit!)
    @review.video = @video
    @review.user = current_user
    @review.save
    if @review.valid?
    render "videos/show"
    flash[:success] = "Your review is posted"
    else
    flash[:error] = "#{@review.errors.full_messages.join(" ")}"
    redirect_to video_path(@video)
    end
  end
end