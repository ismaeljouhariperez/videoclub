class MoviesController < ApplicationController
  def index
    @movies = Movie.page(params[:page]).per(20)
    @lists_sidebar = List.where(user: current_user).order(updated_at: :desc).first(5)
  end

  def show
    @movie = Movie.find(params[:id])
    @lists_sidebar = List.where(user: current_user).order(updated_at: :desc).first(5)
  end
end
