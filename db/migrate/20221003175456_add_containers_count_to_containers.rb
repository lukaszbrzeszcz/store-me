class AddContainersCountToContainers < ActiveRecord::Migration[7.0]
  def change
    add_column :containers, :containers_count, :integer, null: false, default: 0
  end
end
