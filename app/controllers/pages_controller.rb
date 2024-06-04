class PagesController < ApplicationController
  before_action :authenticate_user!

  def home

    @lists = List.where(user: current_user)
    @movies = Movie.all

  end
end
