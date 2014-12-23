class Admin::VideosController < AdminController
  def add_video
    @video = Video.new
  end
  def create
    video = Video.create(params_video)
    if video.valid?
      redirect_to admin_add_video_path
      flash[:success]="You added a video #{video.title} cuccessfully."
    else
      @video = video
      render "add_video"
      flash.now[:danger] = "You failed to add a video"
    end
  end

  private
  def params_video
    params.require(:video).permit(:title,:category_id,:description,:large_cover, :small_cover, :video_url, :avatar_cache)    
  end
end