class GptQuery < ApplicationRecord
  belongs_to :user
  has_many :movies, through: :query_movies
end
  