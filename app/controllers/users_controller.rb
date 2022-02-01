class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      flash.now[:user_errors] = 'User Not Registered'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end 
  
  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
