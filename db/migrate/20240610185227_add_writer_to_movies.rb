class AddWriterToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :writer, :string
  end
end
