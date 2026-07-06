class PlayWeeksController < ApplicationController
  before_action :require_operator
  before_action :set_play_week, only: [:show, :update, :destroy, :publish_day]

  def index
    @play_weeks = PlayWeek.order(start_date: :desc)
    render json: @play_weeks.map { |pw| play_week_json(pw) }
  end

  def show
    render json: play_week_json(@play_week, include_screenings: true)
  end

  def create
    @play_week = PlayWeek.new(play_week_params)
    if @play_week.save
      render json: play_week_json(@play_week), status: :created
    else
      render json: @play_week.errors, status: :unprocessable_entity
    end
  end

  def update
    if @play_week.update(play_week_params)
      render json: play_week_json(@play_week)
    else
      render json: @play_week.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @play_week.screenings.exists?
      render json: { error: "Cannot delete a play week that has screenings" },
        status: :unprocessable_entity
    else
      @play_week.destroy
      head :no_content
    end
  end

  def publish_day
    day = params[:day]
    unless day.present?
      render json: { error: "Day parameter required" }, status: :unprocessable_entity
      return
    end

    target_date = Date.parse(day)
    screenings = @play_week.screenings
      .where(status: 'planned')
      .where(
        "(showtime AT TIME ZONE 'UTC' AT TIME ZONE ?)::date = ?",
        @play_week.screenings.first&.screen&.location&.state&.time_zone || 'America/Chicago',
        target_date
      )
    
    count = screenings.count
    screenings.update_all(status: 'published')

    render json: { published: count, message: "#{count} showing#{'s' if count != 1} published successfully" }
  end

  def publish_batch
    ids = params[:screening_ids]
    unless ids.present?
      render json: { error: "screening_ids parameter required" }, status: :unprocessable_entity
      return
    end

    screenings = Screening.where(id: ids, status: 'planned')
    count = screenings.count
    screenings.update_all(status: 'published')

    render json: { published: count, message: "#{count} showing#{'s' if count != 1} published successfully" }
  end

  private

  def set_play_week
    @play_week = PlayWeek.find(params[:id])
  end

  def play_week_params
    params.require(:play_week).permit(:start_date, :end_date, :notes)
  end

  def play_week_json(play_week, include_screenings: false)
    data = {
      id: play_week.id,
      start_date: play_week.start_date,
      end_date: play_week.end_date,
      notes: play_week.notes,
      status: play_week.status,
      published_count: play_week.screenings.where(status: 'published').count,
      planned_count: play_week.screenings.where(status: 'planned').count,
      total_count: play_week.screenings.count
    }

    if include_screenings
      date[:screenings] = play_week.screenings
        .includes(:movie, screen: :location)
        .order(:showtime)
        .map { |s| screening_summary(s) }
    end

    data
  end

  def screening_summary(screening)
    {
      id: screening.id,
      movie_id: screening.movie_id,
      movie_title: screening.movie.title,
      movie_color: screening.movie.color,
      movie_poster_url: screening.movie.poster_url,
      movie_duration: screening.movie.duration,
      screen_id: screening.screen_id,
      screen_name: screening.screen.name,
      showtime: screening.showtime,
      price: screening.price,
      seats_total: screening.seats_total,
      seats_available: screening.seats_available,
      status: screening.status,
      bookable: screening.bookable?
    }
  end
end
