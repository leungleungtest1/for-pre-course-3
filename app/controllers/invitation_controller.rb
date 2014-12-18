class InvitationController < ApplicationController
  before_action :require_log_in, only: [:send_invitation]
  def invite_friends
    
  end

  def send_invitation
    if params[:name]=="" || params[:email] == ""
      flash[:danger] = "Both name and email row cannot be blank."
      redirect_to invite_friends_path
    elsif !is_a_valid_email?(params[:email])
      flash[:danger] = "Eamil address you input is invalid."
      redirect_to invite_friends_path
    else
      AppMailer.delay.send_invitation_email(current_user, params[:name], params[:email],params[:message])
      flash[:success] = "you send a email successfully."
      redirect_to invite_friends_path
    end
    
  end

  private
  def is_a_valid_email?(email)
    email_regex = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    email =~ email_regex
  end
end