class CreateContainerEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :container_events do |t|
      t.references :container, null: false, foreign_key: true, type: :uuid
      t.string :event_type
      t.json :payload

      t.timestamps
    end
  end
end
