class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lists, dependent: :destroy
  has_many :watched_movies, dependent: :destroy
  has_many :movies, through: :watched_movies
  has_many :gpt_queries, dependent: :destroy
  has_many :query_movies, through: :gpt_queries
  has_many :favorites, dependent: :destroy

end
