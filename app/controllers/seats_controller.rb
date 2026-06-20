class SeatsController < ApplicationController
  before_action :set_seat

  # PATCH /seats/:id
  def update
    if @seat.update(seat_params)
      render json: {
        id: @seat.id,
        label: @seat.label,
        seat_type: @seat.seat_type,
        position: @seat.position,
        active: @seat.active
      }
    else
      render json: @seat.errors, status: :unprocessable_entity
    end
  end

  private

  def set_seat
    @seat = Seat.find(params[:id])
  end

  def seat_params
    params.require(:seat).permit(:seat_type, :active)
  end
end
