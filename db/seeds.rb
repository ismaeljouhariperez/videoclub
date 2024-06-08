require 'faker'
require 'net/http'
require 'json'
require 'dotenv/load'

User.destroy_all if Rails.env.development?
List.destroy_all if Rails.env.development?
ListMovie.destroy_all if Rails.env.development?
Movie.destroy_all if Rails.env.development?

User.create(email: 'ismael@test.com', password: 'azerty', username: "Arrancini")
User.create(email: 'killian@test.com', password: 'azerty', username: "The Goat")
User.create(email: 'benoit@test.com', password: 'azerty', username: "Korben")

# url = URI.parse('https://tmdb.lewagon.com/movie/top_rated') # API le wagon
base_url = "https://api.themoviedb.org/3/movie/top_rated"

puts "Creating 200 movies..."
for i in 1..100
  # Stop the loop if we have enough movies like 100
  break if Movie.count >= 200
  # Get API key from .env file
  api_key = ENV['TMDB_API_KEY']
  page = i
  params = { api_key: api_key, page: page }
  # API url to get top rated movies from TMDB
  uri = URI(base_url)
  # Add the API key and page number to the URL
  uri.query = URI.encode_www_form(params)

  response = Net::HTTP.get_response(uri)
  data = JSON.parse(response.body)

  # Create a movie for each movie in the API response
  data['results'].each do |movie|
    # Get more details about the movie and get imdb_id
    one_movie = JSON.parse(Net::HTTP.get_response(URI("https://api.themoviedb.org/3/movie/#{movie['id']}?api_key=#{api_key}")).body)
    # Get the trailer for the movie
    find_trailer = JSON.parse(Net::HTTP.get_response(URI("http://api.themoviedb.org/3/movie/#{movie['id']}/videos?api_key=#{api_key}")).body)
    trailer = find_trailer['results'].find { |video| video['type'] == 'Trailer' && video['site'] == 'YouTube' && video['official'] == true }

    # Call the OMDB API to get more details about the movie
    omdb_api_url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}&i=#{one_movie['imdb_id']}"
    one_movie_omdb = JSON.parse(Net::HTTP.get_response(URI(omdb_api_url)).body)
    Movie.create(
      title: one_movie_omdb['Title'],
      description: one_movie_omdb['Plot'],
      year: movie['release_date'].split('-').first,
      actors: one_movie_omdb['Actors'],
      director: one_movie_omdb['Director'],
      poster_url: one_movie_omdb["Poster"],
      imdb_id: one_movie_omdb['imdbID'],
      trailer_key: trailer ? trailer['key'] : nil
    )
  end
end
puts "Movies created!"


list_title = ["Top 10", "Horror", "Comedy"]
users = User.all

list_title.each.with_index do |list_name, i|
  users.each do |user|
    List.create(name: list_name, user_id: user.id)
  end
end
