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
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    token = params[:stripeToken]
    customer = StripeWrapper::Customer.create(token,@user)

    if customer.successful?
      flash[:warning] = "You paid 9 dollars and 99 cents"
      flash[:success] = "#{@user.name} register successfully."
      @user.customer_token = customer.response.id
      @user.save
      redirect_to sign_in_path
    else
      flash[:warning] = customer.error_message
      flash[:danger] = "You failed to register and are not charged"
      redirect_to register_path
    end

  end

  def show
    @user = User.find_by_token params[:id]
    render "show"
  end


end