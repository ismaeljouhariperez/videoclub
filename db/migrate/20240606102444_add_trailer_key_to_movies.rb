class AddTrailerKeyToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :trailer_key, :string
  end
end
