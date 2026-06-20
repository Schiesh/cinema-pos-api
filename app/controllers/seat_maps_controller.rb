class SeatMapsController < ApplicationController
  before_action :set_screen

  # GET /screens/:screen_id/seat_map
  def show
    @seat_map = @screen.seat_map

    if @seat_map.nil?
      render json: { error: "No seat map configured for this screen" }, status: :not_found
      return
    end

    render json: seat_map_json(@seat_map)
  end

  # POST /screens/:screen_id/seat_map
  def create
    if @screen.has_seat_map?
      render json: { error: "Screen already has a seat map" }, status: :unprocessable_entity
      return
    end

    @seat_map = @screen.create_seat_map!(rows: seat_map_params[:rows])

    @seat_map.generate_rows(
      seat_map_params[:seats_per_row].to_i,
      has_aisle: seat_map_params[:has_aisle] == "true",
      aisle_after_seat: seat_map_params[:aisle_after_seat]&.to_i
    )

    render json: seat_map_json(@seat_map), status: :created
  end

  # PATCH /screens/:screen_id/seat_map
  def update
    @seat_map = @screen.seat_map

    if @seat_map.nil?
      render json: { error: "No seat map found" }, status: :not_found
      return
    end

    if @seat_map.update(rows: seat_map_params[:rows])
      render json: seat_map_json(@seat_map)
    else
      render json: @seat_map.errors, status: :unprocessable_entity
    end
  end

  private

  def set_screen
    @screen = Screen.find(params[:screen_id])
  end

  def seat_map_params
    params.require(:seat_map).permit(:rows, :seats_per_row, :has_aisle, :aisle_after_seat)
  end

  def seat_map_json(seat_map)
    {
      id: seat_map.id,
      screen_id: seat_map.screen_id,
      rows: seat_map.rows,
      total_seats: seat_map.seats.count,
      standard_seats: seat_map.seats.standard.count,
      premium_seats: seat_map.seats.premium.count,
      accessible_seats: seat_map.seats.accessible.count,
      seat_map_rows: seat_map.seat_map_rows.order(:row_letter).map do |row|
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
    }
  end
end
