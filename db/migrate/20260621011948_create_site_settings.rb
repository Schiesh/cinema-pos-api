class CreateSiteSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :site_settings do |t|
      t.string :time_zone, null: false, default: "Central Time (US & Canada)"
      t.timestamps
    end
  end
end