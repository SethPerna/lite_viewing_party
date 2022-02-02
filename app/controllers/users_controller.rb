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

  def discover
    @user = User.find(params[:id])
    if params[:top_rated].present?
      conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
        faraday.params[:api_key] = ENV['movie_api_key']
      end
      response = conn.get('/3/movie/top_rated')

      data = JSON.parse(response.body, symbolize_names: true)
      binding.pry
      movies = data[:results][0][:members]

      found_members = members.find_all { |m| m[:last_name] == params[:search] }
      @member = found_members.first
      render 'discover'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
