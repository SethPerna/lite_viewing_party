class UsersMoviesPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = SingleMovie.new.search(params[:movie_id])
    @party = Party.new
    @users = User.all.where.not(id: params[:user_id])
  end
end
