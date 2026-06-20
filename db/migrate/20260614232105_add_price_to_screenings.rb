class AddPriceToScreenings < ActiveRecord::Migration[8.1]
  def change
    add_column :screenings, :price, :decimal
  end
end
