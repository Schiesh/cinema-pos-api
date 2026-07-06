class CreatePlayWeeks < ActiveRecord::Migration[8.1]
  def change
    create_table :play_weeks do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :notes
      t.timestamps
    end

    add_index :play_weeks, :start_date, unique: true
  end
end
