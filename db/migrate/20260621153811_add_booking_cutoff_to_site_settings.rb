class AddBookingCutoffToSiteSettings < ActiveRecord::Migration[8.1]
  def change
    add_column :site_settings, :booking_cutoff_minutes, :integer, null: false, default: 0
    remove_column :site_settings, :time_zone, :string
  end
end