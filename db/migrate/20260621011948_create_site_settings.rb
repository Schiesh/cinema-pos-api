class CreateSiteSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :site_settings do |t|
      t.integer :booking_cutoff_minutes, null: false, default: 0
      t.timestamps
    end
  end
end