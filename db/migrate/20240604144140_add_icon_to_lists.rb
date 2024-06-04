class AddIconToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :icon, :string
  end
end
