require 'json'

class GptQuery < ApplicationRecord
  belongs_to :user
  has_many :query_movies, dependent: :destroy
  has_many :movies, through: :query_movies

  after_create :create_query_movies

  def create_query_movies
    response = ChatGptService.new.get_recommendations(self)

    # Extract JSON part from the response
    json_start = response.index('[')
    json_end = response.rindex(']') + 1
    json_string = response[json_start...json_end]

    # Parse the extracted JSON string
    JSON.parse(json_string).each do |reco|
      movie_id = reco["imdb_id"]
      movie = Movie.custom_find_or_create_by_imndb_id(movie_id)
      QueryMovie.create(movie: movie, reco_title: reco["title"], reco_description: reco["description"], gpt_query: self)
    end

  rescue JSON::ParserError => e
    Rails.logger.error "Failed to parse JSON: #{e.message}"
    # Handle the error appropriately, e.g., by notifying the user or re-attempting the request
  end

  def associated_movies
    Favorite.where(user: self.user).map(&:movie).map(&:imdb_id).shuffle.join(", ")
  end

  def show
    @gpt_query = GptQuery.find(params[:id])
  end
end
