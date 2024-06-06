class WatchLaterController < ApplicationController
  def index
    @watch_laters = current_user.watched_movies.where(is_watched: false)
  end
end
