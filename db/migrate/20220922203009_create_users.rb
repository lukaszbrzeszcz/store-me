class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :password_digest, null: false, default: ''
      t.integer :sign_in_count, null: false, default: 0
      t.timestamp :current_sign_in_at
      t.timestamp :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
