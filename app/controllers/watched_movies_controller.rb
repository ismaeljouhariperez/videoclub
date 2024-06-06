class WatchedMoviesController < ApplicationController
  def index
    @watched_movies = current_user.watched_movies.where(is_watched: true)
  end

  def create
    raise
    @movie = Movie.find(params[:movie_id])
    current_user.watched_movies << @movie
    redirect_to movie_path(@movie)
  end
end
