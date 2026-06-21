class ScreeningsController < ApplicationController
  before_action :set_movie, only: [:index, :create]
  before_action :set_screening, only: [:show, :update, :destroy]

  # GET /movies/:movie_id/screenings
  def index
    @screenings = @movie.screenings.includes(:screen)
    render json: @screenings.map { |s| screening_json(s) }
  end

  # GET /screenings/:id
  def show
    render json: screening_json(@screening)
  end

  # POST /movies/:movie_id/screenings
  def create
    zone = ActiveSupport::TimeZone[params[:screening][:time_zone]] || Time.zone
    local_time = zone.parse(params[:screening][:showtime])

    @screening = @movie.screenings.build(screening_params.except(:time_zone))
    @screening.showtime = local_time

    if @screening.save
      render json: screening_json(@screening), status: :created
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  # PATCH /screenings/:id
  def update
    if @screening.update(screening_params)
      render json: screening_json(@screening)
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  # DELETE /screenings/:id
  def destroy
    @screening.destroy
    head :no_content
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_screening
    @screening = Screening.find(params[:id])
  end

  def screening_params
    params.require(:screening).permit(
      :showtime, :seats_available, :seats_total,
      :screen_number, :screen_id, :price, :time_zone
    )
  end

  def screening_json(screening)
    {
      id: screening.id,
      movie_id: screening.movie_id,
      screen_id: screening.screen_id,
      screen_name: screening.screen&.name,
      screen_type: screening.screen&.screen_type,
      showtime: screening.showtime,
      seats_available: screening.seats_available,
      seats_total: screening.seats_total,
      price: screening.price,
      screen_number: screening.screen_number,
      percent_full: screening.seats_total > 0 ? 
        ((screening.seats_total - screening.seats_available).to_f / screening.seats_total * 100).round : 0
    }
  end
end
