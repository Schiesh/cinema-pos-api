class AddBookingFieldsToScreenings < ActiveRecord::Migration[8.1]
  def change
    add_column :screenings, :status, :string, null: false, default: "published"
    add_column :screenings, :play_week_id, :integer
    add_index :screenings, :status
    add_index :screenings, :play_week_id
  end
end
