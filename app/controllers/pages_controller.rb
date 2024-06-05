class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @movies = Movie.all
  end
end
