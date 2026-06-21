class MakeLocationRequiredOnScreens < ActiveRecord::Migration[8.1]
  def change
    change_column_null :screens, :location_id, false
  end
end
