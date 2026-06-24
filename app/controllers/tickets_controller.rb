class TicketsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :book]
  before_action :set_screening, only: [:index, :create]
  before_action :set_ticket, only: [:show, :update, :destroy, :book]

  # GET /screenings/:screening_id/tickets
  def index
    @tickets = @screening.tickets
    render json: @tickets
  end

  # GET /tickets/:id
  def show
    render json: @ticket
  end

  # POST /screenings/:screening_id/tickets
  def create
    @ticket = @screening.tickets.build(ticket_params)
    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # POST /tickets/:id/book
  def book
    if @ticket.status != "available"
      render json: { error: "Ticket is not available" }, status: :unprocessable_entity
      return
    end

    if @ticket.update(
      status: "sold",
      customer_name: params[:customer_name],
      customer_email: params[:customer_email]
    )
      # update available seats on the screening
      @ticket.screening.decrement!(:seats_available)

      render json: {
        message: "Ticket booked successfully",
        ticket: @ticket,
        seats_remaining: @ticket.screening.seats_available
      }
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH /tickets/:id
  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/:id
  def destroy
    @ticket.destroy
    head :no_content
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:seat_number, :status, :price, :customer_name, :customer_email)
  end
end
