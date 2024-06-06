class GptQuery < ApplicationRecord
  belongs_to :user
  has_many :query_movies, dependent: :destroy
  has_many :movies, through: :query_movies
end
