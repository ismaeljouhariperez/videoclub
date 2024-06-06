class CreateGptQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :gpt_queries do |t|
      t.text :query
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
