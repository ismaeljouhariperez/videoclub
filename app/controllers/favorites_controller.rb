class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @favorite = Favorite.find_or_initialize_by(movie: @movie, user: current_user)

    if @favorite.save
      message = 'Movie marked as favorite'
      render json: {
        status: 'success',
        message: message,
      }, status: :ok
    else
      render json: { status: 'error', message: @favorite.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end
end
