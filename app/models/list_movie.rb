class ListMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  has_many :movies, through: :list

  validates :movie_id, uniqueness: { scope: :list_id }
end
