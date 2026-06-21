class AddLocationToScreens < ActiveRecord::Migration[8.1]
  def change
    add_reference :screens, :location, null: true, foreign_key: true
  end
end