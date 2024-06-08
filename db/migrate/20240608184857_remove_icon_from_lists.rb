class RemoveIconFromLists < ActiveRecord::Migration[7.1]
  def change
    remove_column :lists, :icon, :string
  end
end
