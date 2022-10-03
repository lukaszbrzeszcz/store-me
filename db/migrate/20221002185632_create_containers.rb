class CreateContainers < ActiveRecord::Migration[7.0]
  def change
    create_table :containers, id: :uuid do |t|
      t.string :barcode, null: false, default: ''
      t.string :name, null: false, default: ''
      t.references :container, null: true, foreign_key: true, type: :uuid
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.references :image, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
