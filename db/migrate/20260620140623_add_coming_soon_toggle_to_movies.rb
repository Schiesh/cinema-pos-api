class AddComingSoonToggleToMovies < ActiveRecord::Migration[8.1]
  def change
    add_column :movies, :coming_soon_toggle, :boolean, null: false, default: false
  end
end