class FavoritesController < ApplicationController
  def index
    if params[:search]
      @favorites = Favorite.where(user: current_user).joins(:movie).where('title ILIKE ?', "%#{params[:search]}%")
    else
      @favorites = Favorite.where(user: current_user)
    end
  end

  def create
    @movie = Movie.find(params[:movie_id])
    # @favorite = Favorite.find_or_initialize_by(movie: @movie, user: current_user)

    @favorite = Favorite.find_by(movie: @movie, user: current_user)

    if @favorite
      @favorite.destroy
      render json: { status: 'success', message: 'Movie removed from favorites' }, status: :ok
    else
      @favorite = Favorite.create(movie: @movie, user: current_user)
      render json: { status: 'success', message: 'Movie added to favorites' }, status: :ok
    end
  end
end
