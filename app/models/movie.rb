class Movie < ApplicationRecord
  has_many :list_movies
  has_many :watched_movies
  has_many :favorites
  has_many :query_movies, dependent: :destroy

  def formatted_runtime
    minutes = runtime.to_i
    hours = minutes / 60
    remaining_minutes = minutes % 60
    "#{hours}h#{remaining_minutes}"
  end

  def self.custom_find_or_create_by_imndb_id(id)
    movie = Movie.find_by(imdb_id: id)
    if movie.nil?
      omdb_api_url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}&i=#{id}"
      response = Net::HTTP.get_response(URI(omdb_api_url))
      if response.is_a?(Net::HTTPSuccess)
        one_movie_omdb = JSON.parse(response.body)
        movie = Movie.create(
          title: one_movie_omdb['Title'],
          description: one_movie_omdb['Plot'],
          year: one_movie_omdb['Year'].to_i,
          actors: one_movie_omdb['Actors'],
          director: one_movie_omdb['Director'],
          poster_url: one_movie_omdb['Poster'],
          imdb_id: id,
          genre: one_movie_omdb['Genre'],
          runtime: one_movie_omdb['Runtime'],
          rating: one_movie_omdb['imdbRating'].to_f
        )
      end
    end
    movie
  end
end
