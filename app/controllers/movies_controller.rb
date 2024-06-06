class MoviesController < ApplicationController
  def index
    if params[:search]
      @movies = Movie.where("title ILIKE ?", "%#{params[:search]}%").page(params[:page]).per(20)
    else
      @movies = Movie.page(params[:page]).per(20)
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
