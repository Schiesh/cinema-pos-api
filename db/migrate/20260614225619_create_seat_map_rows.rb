class CreateSeatMapRows < ActiveRecord::Migration[8.1]
  def change
    create_table :seat_map_rows do |t|
      t.references :seat_map, null: false, foreign_key: true
      t.string :row_letter, null: false
      t.integer :seats_per_row, null: false
      t.boolean :has_aisle, null: false, default: false
      t.integer :aisle_after_seat

      t.timestamps
    end
  end
end
