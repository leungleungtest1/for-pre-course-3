class PeoplesController < ApplicationController
  before_action :require_log_in, only:[:index,:destroy,:create]
  def index
    @user=current_user
  end

  def destroy
    user = User.find params[:id]
    current_user.leaders.delete(user)
    @user = current_user
    flash[:success] = "you unfollow #{user.name} successfully."
    redirect_to peoples_path
  end

  def create
    new_leader = User.find params[:id]
    if session[:user_id] == params[:id].to_i
      flash.now[:error] = "You cannot follow yourselves."
      @user = User.find params[:id]
      render "users/show"
    elsif current_user.follow?(new_leader)
      flash.now[:error] = "You already followed him or her."
      @user = User.find params[:id]
      render "users/show"
    else
      Relationship.create(leader_id: params[:id], follower_id: session[:user_id])
      flash[:success] = "You followed #{new_leader.name}"
      redirect_to peoples_path  
    end
  end
end
