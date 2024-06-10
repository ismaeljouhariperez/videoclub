class AddRecoTitleAndRecoDescriptionToQueryMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :query_movies, :reco_title, :string
    add_column :query_movies, :reco_description, :text
  end
end
