class MoviesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :now_showing, :coming_soon]
  before_action :require_operator, only: [:create, :update, :destroy]
  before_action :set_movie, only: [:show, :update, :destroy]

  # GET /movies
  def index
    @movies = Movie.all
    render json: @movies
  end

  # GET /movies/now_showing
  def now_showing
    render json: Movie.now_showing
  end

  # GET /movies/coming_soon
  def coming_soon
    render json: Movie.coming_soon
  end

  # GET /movies/:id
  def show
    render json: @movie
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: @movie, status: :created
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH /movies/:id
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/:id
  def destroy
    @movie.destroy
    head :no_content
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :genre, :duration, :rating, :price, :poster_url, :coming_soon_toggle)
  end
end
