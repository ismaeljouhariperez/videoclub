class GptQuery < ApplicationRecord
  belongs_to :user
  has_many :query_movies, dependent: :destroy
  has_many :movies, through: :query_movies

  after_create :create_query_movies

  def create_query_movies
    ids = ChatGptService.new.get_imdb_ids(self.query)
    ids.each do |id|
      movie = Movie.custom_find_or_create_by_imndb_id(id)
      QueryMovie.create(movie: movie, gpt_query: self)
    end
  end
end
