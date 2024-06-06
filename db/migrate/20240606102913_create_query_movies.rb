class CreateQueryMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :query_movies do |t|
      t.references :gpt_querie, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
