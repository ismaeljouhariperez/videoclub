require 'dotenv/load'
require 'net/http'
require 'json'
require 'openai'

class RecommendationsController < ApplicationController
  def index
    GptQuery.create(query: params[:query], user: current_user) if params[:query].present?
    @queries = GptQuery.where(user: current_user).order(created_at: :desc)
    end
end
