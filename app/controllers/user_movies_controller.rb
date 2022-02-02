class UsersMoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:top_rated].present?
      @top_movies = TopRated.new.movies
      render 'index'
    elsif params[:search].present?
      @search_movie = SearchMovie.new.search(params[:search])
      render 'index'
    end
  end
end
