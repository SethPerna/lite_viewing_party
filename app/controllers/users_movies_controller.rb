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
    @user = User.find(params[:user_id])
    @movie = SingleMovie.new.search(params[:id])
    @reviews = FindReview.new.search(params[:id])
    render 'users/movies/show'
  end
end
