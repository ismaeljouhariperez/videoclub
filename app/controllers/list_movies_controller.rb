class ListMoviesController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:movie_id])

    @list_movie = ListMovie.new(list: @list, movie: @movie)

    if @list_movie.save
      render json: { status: 'success', message: 'Movie successfully added to the list.' }, status: :ok
    else
      render json: { status: 'error', message: @list_movie.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end
end
