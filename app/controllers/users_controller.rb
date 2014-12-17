class UsersController < ApplicationController
  before_action :require_log_in, only:[:show]
  def new
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
      becomes_friend(@user,invitor)
      invitor.update_column(:token, SecureRandom.urlsafe_base64) if invitor
      AppMailer.send_welcome_email(@user).deliver
      Appmailer.send_simple_message.deliver
      flash[:success] = "#{@user.name} register successfully."
           redirect_to sign_in_path
     else
      flash.now[:warning] = @user.errors.full_messages.join(', ')
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