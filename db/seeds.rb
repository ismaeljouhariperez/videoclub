require 'faker'
require 'net/http'
require 'json'

User.destroy_all if Rails.env.development?
Watched.destroy_all if Rails.env.development?
List.destroy_all if Rails.env.development?
ListMovie.destroy_all if Rails.env.development?
Movie.destroy_all if Rails.env.development?

User.create(email: 'ismael@test.com', password: 'azerty')
User.create(email: 'killian@test.com', password: 'azerty')
User.create(email: 'benoit@test.com', password: 'azerty')


url = URI.parse('https://tmdb.lewagon.com/movie/top_rated')
response = Net::HTTP.get_response(url)
data = JSON.parse(response.body)

data['results'].each do |movie|
  Movie.create(
    title: movie['title'],
    description: movie['overview'],
    year: movie['release_date'].split('-').first,
    actors: Faker::Movies::HarryPotter.character,
    director: Faker::Movies::HarryPotter.character,
    # poster_url: "https://image.tmdb.org/t/p/w1280#{movie['poster_path']}",
  )
end
