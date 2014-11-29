class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :log_in?
  def log_in?
    !!session[:user_id]
  end

  def current_user
    if log_in?
    @current_user = User.find session[:user_id]
    end
  end

  def require_log_in
    unless log_in?
      flash[:error] = "You have to log in to do it"
      redirect_to sign_in_path
    end
  end
end
