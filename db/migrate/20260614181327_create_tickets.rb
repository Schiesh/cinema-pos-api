class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.integer :screening_id
      t.string :seat_number
      t.string :status
      t.decimal :price
      t.string :customer_name
      t.string :customer_email

      t.timestamps
    end
  end
end
