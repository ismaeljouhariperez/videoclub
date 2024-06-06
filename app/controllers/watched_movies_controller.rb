class WatchedMoviesController < ApplicationController
  def index
    @watched_movies = current_user.watched_movies.where(is_watched: true)
  end

  def create
    @watched_movie = current_user.watched_movies.find_or_create_by(movie_id: params[:movie_id])
    @watched_movie.is_watched = true

    if @watched_movie.save
      respond_to do |format|
        format.json { render json: { status: 'success', message: 'Movie marked as watched' }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { status: 'error', message: 'Failed to mark as watched' }, status: :unprocessable_entity }
      end
    end
  end
end
