class RemoveGptQuerieFromQueryMovies < ActiveRecord::Migration[7.1]
  def change
    remove_reference :query_movies, :gpt_querie, null: false, foreign_key: true
  end
end
