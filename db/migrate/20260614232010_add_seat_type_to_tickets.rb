class AddSeatTypeToTickets < ActiveRecord::Migration[8.1]
  def change
    add_column :tickets, :seat_type, :string, default: "standard"
  end
end
