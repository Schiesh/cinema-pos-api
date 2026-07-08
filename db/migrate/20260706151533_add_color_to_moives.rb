class AddColorToMoives < ActiveRecord::Migration[8.1]
  def change
    add_column :movies, :color, :string, null: false, default: "#888888"
  end
end
