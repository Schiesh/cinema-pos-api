class CreateStates < ActiveRecord::Migration[8.1]
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.string :abbreviation, null: false
      t.string :time_zone, null: false
      t.timestamps
    end

    add_index :states, :abbreviation, unique: true
  end
end
