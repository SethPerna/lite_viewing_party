class UsersController < ApplicationController
  before_action :current_user, only: [:show]

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
    #@user = User.find(session[:user_id])

    @invited_parties = @user.invites
    @movies = @user.parties.map { |party| SingleMovie.new.search(party.movie_id) }
    @host_parties = @user.hosting
  end

  def discover
    @user = User.find(session[:user_id])

  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}"
      redirect_to '/dashboard'
    else
      flash[:error] = "Invalid email/password"
      render :login_form
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
