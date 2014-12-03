class MyqueuesController < ApplicationController
  before_action :require_log_in
  def index
    @myqueue = Myqueue.find_by(user_id: session[:user_id])
  end
end 