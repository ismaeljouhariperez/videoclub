require 'json'

class GptQuery < ApplicationRecord
  belongs_to :user
  has_many :query_movies, dependent: :destroy
  has_many :movies, through: :query_movies

  after_create :create_query_movies

  def create_query_movies
    JSON.parse(ChatGptService.new.get_recommendations(self)).each do |reco|
      {"imdb_id"=>"tt0080684", "title"=>"Epic Saga Continues Intensely", "description"=>"Given your taste for classics and strong narratives, try this sequel."}
      movie_id = reco["imdb_id"]
      movie = Movie.custom_find_or_create_by_imndb_id(movie_id)
      QueryMovie.create(movie: movie, reco_title: reco["title"], reco_description: reco["description"], gpt_query: self)
    end
  end

  def associated_movies
    Favorite.where(user: self.user).map(&:movie).map(&:imdb_id).join(", ")
  end
end
