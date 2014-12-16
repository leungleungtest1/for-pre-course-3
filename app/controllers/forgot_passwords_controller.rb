class ForgotPasswordsController < ApplicationController
  def new
    
  end

  def create
    @email = params[:email]
    @user = User.where(email: params[:email]).first
    if @user
      AppMailer.set_pp_email(@user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger]= "There is no user with that email in the system."
      redirect_to forgot_password_path
    end
  end

  def show
    @user = User.find_by(token: params[:id])
  end

  def confirm
    render "confirm"
  end
end