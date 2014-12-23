class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :log_in?
  private
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
      flash[:danger] = "You have to log in to do it"
      redirect_to sign_in_path
    end
  end

  def requrie_admin
    unless current_user.admin
      flash[:danger] = "You are not authorized to access this area."
      redirect_to home_path
    end
  end
end
