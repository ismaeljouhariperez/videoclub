class AddPosterUrlToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :poster_url, :string
  end
end
