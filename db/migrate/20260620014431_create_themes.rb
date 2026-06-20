class CreateThemes < ActiveRecord::Migration[8.1]
  def change
    create_table :themes do |t|
      t.string :primary_color
      t.string :secondary_color
      t.string :info_color
      t.string :success_color
      t.string :danger_color
      t.string :background_color
      t.string :text_color

      t.timestamps
    end
  end
end
