class SeatMapRowsController < ApplicationController
  before_action :set_seat_map, only: [:create]
  before_action :set_row, only: [:update, :destroy]

  # POST /screens/:screen_id/seat_map/seat_map_rows
  def create
    @row = @seat_map.seat_map_rows.build(row_params)
    if @row.save
      render json: row_json(@row), status: :created
    else
      render json: @row.errors, status: :unprocessable_entity
    end
  end

  # PATCH /seat_map_rows/:id
  def update
    if @row.update(row_params)
      render json: row_json(@row)
    else
      render json: @row.errors, status: :unprocessable_entity
    end
  end

  # DELETE /seat_map_rows/:id
  def destroy
    @row.destroy
    head :no_content
  end

  private

  def set_seat_map
    screen = Screen.find(params[:screen_id])
    @seat_map = screen.seat_map
  end

  def set_row
    @row = SeatMapRow.find(params[:id])
  end

  def row_params
    params.require(:seat_map_row).permit(:row_letter, :seats_per_row, :has_aisle, :aisle_after_seat)
  end

  def row_json(row)
    {
      id: row.id,
      row_letter: row.row_letter,
      seats_per_row: row.seats_per_row,
      has_aisle: row.has_aisle,
      aisle_after_seat: row.aisle_after_seat,
      seats: row.seats.by_position.map do |seat|
        {
          id: seat.id,
          label: seat.label,
          seat_type: seat.seat_type,
          position: seat.position,
          active: seat.active
        }
      end
    }
  end
end
