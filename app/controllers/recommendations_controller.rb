require 'dotenv/load'
require 'net/http'
require 'json'
require 'openai'

class RecommendationsController < ApplicationController
  def index
    if params[:query].present?
      client = OpenAI::Client.new
      chatgpt_response = client.chat(parameters: {
        model: "gpt-4-turbo",
        # messages: [{ role: "user", content: "You are Movies GPT, an encyclopedia for movies. Give me 10 imdb ids. For this user request who is looking for a movie recommndations: #{params[:query]} give me ids only." }]
        messages: [{ role: "user", content: "You are MoviesGPT, a film enthusiast and recommender. Analyze this user's query: #{params[:query]}.
        1. Identify key elements: genre preferences, actors/directors mentioned, mood/themes sought, etc.
        2. Based on those elements, suggest 5 IMDb IDs of movies that best match their interests."
      }]})

      GptQuery.create(query: params[:query], user_id: :current_user)

      ids = chatgpt_response["choices"][0]["message"]["content"].scan(/tt\d{7}/)

      ids.each do |id|
        
        unless Movie.exists?(imdb_id: id)
          omdb_api_url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}&i=#{id}"
          response = Net::HTTP.get_response(URI(omdb_api_url))
          if response.is_a?(Net::HTTPSuccess)
            one_movie_omdb = JSON.parse(response.body)
            Movie.create(
              title: one_movie_omdb['Title'],
              description: one_movie_omdb['Plot'],
              year: one_movie_omdb['Year'].to_i,
              actors: one_movie_omdb['Actors'],
              director: one_movie_omdb['Director'],
              poster_url: one_movie_omdb['Poster'],
              imdb_id: id
            )

          end
        end
      end
      @movies = Movie.where(imdb_id: ids)
    else
      @movies = Movie.all
    end
  end
end
