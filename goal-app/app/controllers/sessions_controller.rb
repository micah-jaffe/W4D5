class SessionsController < ApplicationController
  def new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:username], 
      params[:user][:password])
      
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:error] = "Invalid credentials"
      render :new
    end
  end
  
  def destroy
    log_out!
    redirect_to new_user_url
  end
end