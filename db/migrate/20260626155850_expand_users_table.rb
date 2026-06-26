class ExpandUsersTable < ActiveRecord::Migration[8.1]
  def change
    # Add new columns
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :phone, :string
    add_column :users, :preferences, :jsonb, default: {}

    # Remove username since we're moving to email-based login
    remove_column :users, :username, :string

    # Add unique index on email
    add_index :users, :email, unique: true
  end
end