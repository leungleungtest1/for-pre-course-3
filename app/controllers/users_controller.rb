class UsersController < ApplicationController
  before_action :require_log_in, only:[:show]
  def new
    @user = User.new  
  end
  def create
    @categories = Category.all
     @user = User.create( params.require(:user).permit(:name, :password,:email))
    if @user.valid?
      AppMailer.send_welcome_email(@user).deliver
      flash[:success] = "#{@user.name} register successfully."
           redirect_to sign_in_path
     else
      flash.now[:warning] = @user.errors.full_messages.join(', ')
        render 'pages/front'
    end
  end

  def show
    @user = User.find params[:id]
    render "show"
  end

end