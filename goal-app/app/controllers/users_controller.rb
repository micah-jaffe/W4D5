class UsersController < ApplicationController
  def index
    render :index
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  def new
    render :new
  end
  
  def edit
    @user = User.find(params[:id])
    render :edit
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash[:errors] = "Invalid credentials"
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      flash[:errors] = "Invalid credentials"
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to new_user_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end