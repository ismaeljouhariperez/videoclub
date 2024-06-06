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
puts "Creating 100 movies..."
for i in 1..100
  # Stop the loop if we have enough movies like 100
  break if Movie.count >= 100
  # Get API key from .env file
  api_key = ENV['TMDB_API_KEY']
  page = i
  params = { api_key: api_key, page: page }
  # API url to get top rated movies from TMDB
  base_url = "https://api.themoviedb.org/3/movie/top_rated"
  uri = URI(base_url)
  # Add the API key and page number to the URL
  uri.query = URI.encode_www_form(params)

  response = Net::HTTP.get_response(uri)
  data = JSON.parse(response.body)

  # Create a movie for each movie in the API response
  data['results'].each do |movie|
    one_movie = JSON.parse(Net::HTTP.get_response(URI("https://api.themoviedb.org/3/movie/#{movie['id']}?api_key=#{api_key}")).body)
    find_trailer = JSON.parse(Net::HTTP.get_response(URI("http://api.themoviedb.org/3/movie/#{movie['id']}/videos?api_key=#{api_key}")).body)
    trailer = find_trailer['results'].find { |video| video['type'] == 'Trailer' && video['site'] == 'YouTube' && video['official'] == true }

    omdb_api_url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}&i=#{one_movie['imdb_id']}"
    one_movie_omdb = JSON.parse(Net::HTTP.get_response(URI(omdb_api_url)).body)
    Movie.create(
      title: movie['title'],
      description: movie['overview'],
      year: movie['release_date'].split('-').first,
      actors: one_movie_omdb['Actors'],
      director: one_movie_omdb['Director'],
      poster_url: "https://image.tmdb.org/t/p/w1280#{movie['poster_path']}",
      imdb_id: one_movie['imdb_id'],
      trailer_key: trailer ? trailer['key'] : nil
    )
  end
end
puts "Movies created!"


list_title = ["Favorites", "Watched", "Watch Later", "My list"]
list_icon = ["fa-solid fa-heart", "fa-solid fa-check", "fa-regular fa-clock"]
users = User.all

list_title.each.with_index do |list_name, i|
  users.each do |user|
    List.create(name: list_name, user_id: user.id, icon: list_icon[i])
  end
end
