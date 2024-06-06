class AddGptQueryToQueryMovies < ActiveRecord::Migration[7.1]
  def change
    add_reference :query_movies, :gpt_query, null: false, foreign_key: true
  end
end
