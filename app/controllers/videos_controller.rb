class VideosController < ApplicationController
  before_action :require_log_in
  def index
    @categories = Category.all
    @videos = Video.all
  end

  def show
    @video = Video.find params[:id]
  end
  def search
    @results =  Video.search_by_title(params[:search_term])
    render "search"
  end

end