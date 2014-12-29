require "stripe"
class UsersController < ApplicationController
  before_action :require_log_in, only:[:show]
  def new
    @stripe_public_key = ENV["STRIPE_PUBLIC_KEY"]
    @user = User.new
    if params[:data] && params[:data][:email]
      @email = params[:data][:email]
    end
    if params[:data] && params[:data][:token]
      @token = params[:data][:token]
    end
  end
  
  def create
    @categories = Category.all
    invitor = User.find_by_token(params[:token])
    @user = User.create( params.require(:user).permit(:name, :password,:email))
    token = params[:stripeToken]
    getpaymentmanager = GetPaymentManager.new(@user)
    getpaymentmanager.user_sign_up(token,invitor)
    if getpaymentmanager.successful?
      flash[:warning] = "You paid 9 dollars and 99 cents"
      flash[:success] = "#{@user.name} register successfully."
      redirect_to sign_in_path
    else
      flash[:warning] = getpaymentmanager.error_message
      flash[:danger] = "You failed to register and are not charged"
      redirect_to register_path
    end
  end

  def show
    @user = User.find_by_token params[:id]
    render "show"
  end


end