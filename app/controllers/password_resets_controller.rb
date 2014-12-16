class PasswordResetsController < ApplicationController
  def show
    user = User.where(token: params[:id]).first
    @token = user.token if user
    redirect_to expired_token_path unless user
  end
  def create
    user = User.where(token: params[:token]).first
    if user
      user.password = params[:password]
      user.save
      user.update_column(:token, SecureRandom.urlsafe_base64) if user.valid?
      flash[:success] = "You resetted password successfully. Please Sign in"
      redirect_to sign_in_path
    else
      redirect_to expired_token_path
    end
  end
end