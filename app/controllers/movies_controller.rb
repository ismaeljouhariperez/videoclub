class MoviesController < ApplicationController
  def index
    if params[:search]
      @movies = Movie.where("title ILIKE ?", "%#{params[:search]}%").page(params[:page]).per(18)
    else
      @movies = Movie.page(params[:page]).per(18)
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
