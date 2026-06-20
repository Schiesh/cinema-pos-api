class ScreensController < ApplicationController
  before_action :set_screen, only: [:show, :update, :destroy]

  # GET /screens
  def index
    @screens = Screen.active.order(:name)
    render json: @screens
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
end
