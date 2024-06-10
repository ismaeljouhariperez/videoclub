class WatchLaterController < ApplicationController
  def index
    if params[:search]
     @watch_laters = current_user.watched_movies.where(is_watched: false).joins(:movie).where('title ILIKE ?', "%#{params[:search]}%")
    else
     @watch_laters = current_user.watched_movies.where(is_watched: false)
    end
  end
end
