class AddMovieToChatrooms < ActiveRecord::Migration[7.1]
  def change
    add_reference :chatrooms, :movie, null: false, foreign_key: true
  end
end
