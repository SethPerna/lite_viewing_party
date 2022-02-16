class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      flash.now[:user_errors] = 'Invalid Entry'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def discover
    @user = User.find(params[:id])
  end

  def login_form

  end

  def login_user
    if user = User.find_by(email: params[:email])
      user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.email}"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Invalid email/password"
      redirect_to "/login"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
