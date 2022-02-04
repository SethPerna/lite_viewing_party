class UsersMoviesPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = SingleMovie.new.search(params[:movie_id])
    @users = User.all.where.not(id: params[:user_id])
  end

  def create
    Party.create!(date: "2022-02-06", duration: 160, start_time: '7:00', movie: 'Jurasic Park')
    require "pry"; binding.pry
    Party.create(date: date, duration: params[:duration], start_time: start_time, movie: @movie.title)
  end

  private

  def party_date
    params["date(1i)"] + "-" + params["date(2i)"] + "-" + params["date(3i)"]
  end

  def party_time
    params["time(4i)"] + ":" + params["time(5i)"]
  end

  def party_params
    params.permit(date: party_date, duration: parmas[:duration], start_time: party_time, movie: @movie.title)
end
