class UsersMoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:top_rated].present?
      @top_movies = TopRated.new.movies
      render 'users/movies/index'
    end
  end

  def create
    if params[:search].present?
      @search_movie = SearchMovie.new.search(params[:search])
      render 'users/movies/index'
    end
  end

  def show
    require "pry"; binding.pry
  end
end
