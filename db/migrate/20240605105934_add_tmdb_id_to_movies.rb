class AddTmdbIdToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :tmdb_id, :integer, null: false
  end
end
