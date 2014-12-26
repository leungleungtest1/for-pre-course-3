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
      token = params[:stripeToken]
      charge = StripeWrapper::Charge.create({:amount => 999, :card => token, :description => "payment from #{@user.name}, #{@user.email}"} )
      
      if charge.successful?
        flash[:waring] = "You paid 9 dollars and 99 cents"
        becomes_friend(@user,invitor)
        invitor.update_column(:token, SecureRandom.urlsafe_base64) if invitor
        AppMailer.send_welcome_email(@user).deliver
        flash[:success] = "#{@user.name} register successfully."
        redirect_to sign_in_path
      #rescue Stripe::CardError => e
      else
        @user.destroy
        flash[:waring] = charge.error_message
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