class WatchedMoviesController < ApplicationController
  def index
    if params[:search]
      @watched_movies = current_user.watched_movies.where(is_watched: true).joins(:movie).where('title ILIKE ?', "%#{params[:search]}%")
    else
      @watched_movies = current_user.watched_movies.where(is_watched: true)
    end
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @watched_movie = WatchedMovie.find_by(movie: @movie, user: current_user)

    if @watched_movie
      if @watched_movie.is_watched == params[:is_watched]
        @watched_movie.destroy
        render json: { status: 'success', message: 'Movie watch status removed', is_watched: nil, params: params[:is_watched] }, status: :ok
      else
        @watched_movie.update(is_watched: params[:is_watched])
        message = params[:is_watched] ? 'Movie changed as watched' : 'Movie changed as watch later'
        render json: {
          status: 'success',
          message: message,
          is_watched: @watched_movie.is_watched
        }, status: :ok
      end
    else
      @watched_movie = WatchedMovie.create(movie: @movie, user: current_user, is_watched: params[:is_watched])
      message = params[:is_watched] ? 'Movie marked as watched' : 'Movie marked as watch later'
      render json: {
        status: 'success',
        message: message,
        is_watched: @watched_movie.is_watched
      }, status: :ok
    end
  end
end
