class AddRatingToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :rating, :decimal, precision: 3, scale: 1
  end
end
