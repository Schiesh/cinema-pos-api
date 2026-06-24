class ScreensController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_screen, only: [:show, :update, :destroy]

  # GET /screens
  def index
    @screens = Screen.active.includes(location: :state).order(:name)
    render json: @screens.map { |s| screen_json(s) }
  end

  # GET /screens/:id
  def show
    render json: @screen
  end

  # POST /screens
  def create
    @screen = Screen.new(screen_params)
    if @screen.save
      render json: @screen, status: :created
    else
      render json: @screen.errors, status: :unprocessable_entity
    end
  end

  # PATCH /screens/:id
  def update
    if @screen.update(screen_params)
      render json: @screen
    else
      render json: @screen.errors, status: :unprocessable_entity
    end
  end

  # DELETE /screens/:id
  def destroy
    @screen.update(active: false)
    head :no_content
  end

  private

  def set_screen
    @screen = Screen.find(params[:id])
  end

  def screen_params
    params.require(:screen).permit(:name, :screen_type, :capacity, :description, :active)
  end

  def screen_json(screen)
    {
      id: screen.id,
      name: screen.name,
      screen_type: screen.screen_type,
      capacity: screen.capacity,
      description: screen.description,
      active: screen.active,
      time_zone: screen.location.state.time_zone
    }
  end

end
