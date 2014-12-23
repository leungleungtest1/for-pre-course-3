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
    if @user.valid?
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    binding.pry
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => 999, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => "payment from #{@user.name}, #{@user.email}"
      )
      flash[:waring] = "You paid 9 dollors and 99 cents"
      becomes_friend(@user,invitor)
      invitor.update_column(:token, SecureRandom.urlsafe_base64) if invitor
      AppMailer.send_welcome_email(@user)
      flash[:success] = "#{@user.name} register successfully."
      redirect_to sign_in_path
    rescue Stripe::CardError => e
      # The card has been declined
      @user.destroy
      flash[:waring] = e.message
      flash[:danger] = "You fialed to register"
      redirect_to register_path
    end
      
     else
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      flash.now[:success] = "You are not charged"
      render 'pages/front'
    end
  end

  def show
    @user = User.find_by_token params[:id]
    render "show"
  end

  private
  def becomes_friend(user, invitor)
    Relationship.create(leader_id: user.id,follower_id: invitor.id) if invitor
    Relationship.create(leader_id: invitor.id,follower_id: user.id) if invitor 
  end
end