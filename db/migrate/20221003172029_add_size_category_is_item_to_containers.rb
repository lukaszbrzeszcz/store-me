class AddSizeCategoryIsItemToContainers < ActiveRecord::Migration[7.0]
  def change
    add_column :containers, :size, :string
    add_column :containers, :category, :string
    add_column :containers, :is_item, :boolean
  end
end
