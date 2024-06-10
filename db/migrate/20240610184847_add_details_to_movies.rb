class AddDetailsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :runtime, :string
    add_column :movies, :genre, :string
  end
end
