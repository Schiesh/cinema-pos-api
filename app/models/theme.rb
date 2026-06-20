class Theme < ApplicationRecord
  HEX_COLOR_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/

  validates :primary_color, :secondary_color, :info_color,
            :success_color, :danger_color, :background_color, :text_color,
            presence: true,
            format: { with: HEX_COLOR_REGEX, message: "must be a valid hex color like #e50914" }

  def self.current
    first || create!(
      primary_color: "#e50914",
      secondary_color: "#1a1a1a",
      info_color: "#4a9eff",
      success_color: "#4caf50",
      danger_color: "#f44336",
      background_color: "#0f0f0f",
      text_color: "#ffffff"
    )
  end
end