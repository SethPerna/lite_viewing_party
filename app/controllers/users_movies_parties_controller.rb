class UsersMoviesPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = SingleMovie.new.search(params[:movie_id])
    @users = User.all.where.not(id: params[:user_id])
  end

  def create
    @movie = SingleMovie.new.search(params[:movie_id])
    if @movie.runtime.to_i > params[:duration].to_i
      render 'new', flash[:duration] = "Duration can't be shorter than movies runtime."
    elsif party = Party.create(date: party_date, start_time: party_time, duration: params[:duration],
                               movie: @movie.title, host: params[:user_id])
      redirect_to user_path(params[:user_id])
    end
  end

  private

  def party_date
    params['date(1i)'] + '-' + params['date(2i)'] + '-' + params['date(3i)']
  end

  def party_time
    params['time(4i)'] + ':' + params['time(5i)']
  end
end
