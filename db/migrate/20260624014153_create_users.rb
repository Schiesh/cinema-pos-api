class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :employee_id
      t.string :password_digest
      t.string :pin_digest
      t.string :role, null: false, default: 'cashier'
      t.integer :pin_length, null: false, default: 4
      t.boolean :active, null: false, default: true
      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :employee_id, unique: true
  end
end
