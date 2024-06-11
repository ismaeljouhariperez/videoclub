require 'dotenv/load'
require 'net/http'
require 'json'
require 'openai'

class RecommendationsController < ApplicationController
  def index
    GptQuery.create(query: params[:query], user: current_user) if params[:query].present?
    @queries = GptQuery.where(user: current_user)

    if params[:search]
      @movies = Movie.where("title ILIKE ?", "%#{params[:search]}%").page(params[:page]).per(20)
    else
      @movies = Movie.page(params[:page]).per(20)
      @lists = List.where(user: current_user).order(updated_at: :asc)
    end

    params.delete(:query)
    params.delete(:search)
  end
end
