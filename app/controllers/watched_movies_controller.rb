class WatchedMoviesController < ApplicationController
  def index
    @watched_movies = current_user.watched_movies.where(is_watched: true)
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @watched_movie = WatchedMovie.find_or_initialize_by(movie: @movie, user: current_user)

    @watched_movie.is_watched = params[:is_watched] == 'true'

    if @watched_movie.save
      message = @watched_movie.is_watched ? 'Movie marked as watched' : 'Movie marked as watch later'
      render json: {
        status: 'success',
        message: message,
        is_watched: @watched_movie.is_watched,
        section: params[:section]
      }, status: :ok
    else
      render json: { status: 'error', message: @watched_movie.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end
end
