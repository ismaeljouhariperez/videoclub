class DeleteTmdbIdToMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :tmdb_id, :integer
  end
end
