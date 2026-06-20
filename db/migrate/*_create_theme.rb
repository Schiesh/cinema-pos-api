class CreateThemes < ActiveRecord::Migration[8.1]
  def change
    create_table :themes do |t|
      t.string :primary_color, null: false, default: "#e50914"
      t.string :secondary_color, null: false, default: "#1a1a1a"
      t.string :info_color, null: false, default: "#4a9eff"
      t.string :success_color, null: false, default: "#4caf50"
      t.string :danger_color, null: false, default: "#f44336"
      t.string :background_color, null: false, default: "#0f0f0f"
      t.string :text_color, null: false, default: "#ffffff"

      t.timestamps
    end
  end
end
