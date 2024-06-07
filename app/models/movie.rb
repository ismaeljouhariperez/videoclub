class Movie < ApplicationRecord
  has_many :list_movies
  has_many :watched_movies
  has_many :favorites
end
