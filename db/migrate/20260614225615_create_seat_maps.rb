class CreateSeatMaps < ActiveRecord::Migration[8.1]
  def change
    create_table :seat_maps do |t|
      t.references :screen, null: false, foreign_key: true
      t.integer :rows, null: false, default: 1

      t.timestamps
    end
  end
end
