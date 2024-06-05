class AddImdbIdToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :imdb_id, :string
  end
end
