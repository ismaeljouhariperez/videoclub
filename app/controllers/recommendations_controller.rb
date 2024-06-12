require 'dotenv/load'
require 'net/http'
require 'json'
require 'openai'

class RecommendationsController < ApplicationController
  def index

    GptQuery.create(query: params[:query], user: current_user) if params[:query].present?

    @queries = GptQuery.where(user: current_user)
    @favorites = Favorite.where(user: current_user).map{|favorite| Movie.find(favorite.movie_id)}
    @movies = current_user.query_movies.map{|query| Movie.find(query.movie_id)}.uniq
    @movies = @movies - @favorites
    @movies = @movies.sample(10)
    @favorites = @favorites
    @lists = List.where(user: current_user).order(updated_at: :asc)
    # end
  end
end
