class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

    @lists = List.where(user: current_user)
    @movies = Movie.all

  end
end
