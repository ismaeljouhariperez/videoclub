class CreateWatchedMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :watched_movies do |t|
      t.boolean :is_watched
      t.references :movie, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
