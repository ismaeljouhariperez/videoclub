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
  break if Movie.count >= 100
  api_key = ENV['TMDB_API_KEY']
  page = i
  params = { api_key: api_key, page: page }
  base_url = "https://api.themoviedb.org/3/movie/top_rated"
  uri = URI(base_url)
  uri.query = URI.encode_www_form(params)

  response = Net::HTTP.get_response(uri)
  data = JSON.parse(response.body)

  data['results'].each do |movie|
    Movie.create(
      title: movie['title'],
      description: movie['overview'],
      year: movie['release_date'].split('-').first,
      actors: Faker::Movies::HarryPotter.character,
      director: Faker::Movies::HarryPotter.character,
      poster_url: "https://image.tmdb.org/t/p/w1280#{movie['poster_path']}",
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
