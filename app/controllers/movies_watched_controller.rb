class MoviesWatchedController < ApplicationController

  def create
    raise
    @movie = Movie.find(params[:movie_id])
    current_user.movies_watched << @movie
    redirect_to movie_path(@movie)
  end
end
