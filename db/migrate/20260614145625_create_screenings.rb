class CreateScreenings < ActiveRecord::Migration[8.1]
  def change
    create_table :screenings do |t|
      t.integer :movie_id
      t.datetime :showtime
      t.integer :seats_available
      t.integer :seats_total
      t.integer :screen_number

      t.timestamps
    end
  end
end
