class UsersController < ApplicationController
  def new
    @user = User.new  
  end
  def create
    @categories = Category.all
     @user = User.create( params.require(:user).permit(:name, :password,:email))
    if @user.valid?
      Myqueue.create(user_id: @user.id)
      flash[:success] = "#{@user.name} register successfully."
           redirect_to sign_in_path
     else
      flash.now[:warning] = @user.errors.full_messages.join(', ')
        render 'pages/front'
    end

  end

end