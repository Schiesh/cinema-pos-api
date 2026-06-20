class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.integer :duration
      t.string :rating
      t.decimal :price

      t.timestamps
    end
  end
end
