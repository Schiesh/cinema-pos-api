class CreateSeats < ActiveRecord::Migration[8.1]
  def change
    create_table :seats do |t|
      t.references :seat_map_row, null: false, foreign_key: true
      t.string :label, null: false
      t.string :seat_type, null: false, default: "standard"
      t.integer :position, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
