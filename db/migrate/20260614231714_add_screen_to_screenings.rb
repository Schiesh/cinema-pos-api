class AddScreenToScreenings < ActiveRecord::Migration[8.1]
  def change
    add_reference :screenings, :screen, foreign_key: true
  end
end
