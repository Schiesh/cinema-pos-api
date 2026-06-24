class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    if token.nil?
      render json: { error: 'No token provided' }, status: :unauthorized
      return
    end

    begin
      @current_user_payload = JsonWebToken.decode(token)
    rescue StandardError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def current_user_role
    @current_user_payload&.dig('role')
  end

  def require_operator
    unless current_user_role == 'operator'
      render json: { error: 'Operator access required' }, status: :forbidden
    end
  end
end
