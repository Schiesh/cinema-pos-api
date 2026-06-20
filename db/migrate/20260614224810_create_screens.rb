class CreateScreens < ActiveRecord::Migration[8.1]
  def change
    create_table :screens do |t|
      t.string :name, null: false
      t.string :screen_type, null: false, default: "Standard"
      t.integer :capacity, null: false
      t.string :description
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
