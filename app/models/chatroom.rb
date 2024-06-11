class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :movie_id, presence: true
end
