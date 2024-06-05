class PagesController < ApplicationController
  before_action :authenticate_user!

  def home

    @lists_sidebar = List.where(user: current_user).order(updated_at: :desc).first(5)
    @movies = Movie.all

  end
end
