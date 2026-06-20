class ThemesController < ApplicationController
  # GET /theme
  def show
    render json: Theme.current
  end

  # PATCH /theme
  def update
    theme = Theme.current
    if theme.update(theme_params)
      render json: theme
    else
      render json: theme.errors, status: :unprocessable_entity
    end
  end

  private

  def theme_params
    params.require(:theme).permit(
      :primary_color, :secondary_color, :info_color,
      :success_color, :danger_color, :background_color, :text_color
    )
  end
end
