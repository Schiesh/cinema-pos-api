class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :pin_login]

  # POST /auth/login (operator panel - username + password)
  def login
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password]) && user.active? && user.operator?
      token = JsonWebToken.encode({
        user_id: user.id,
        role: user.role,
        username: user.username
      })
      render json: {
        token: token,
        role: user.role,
        username: user.username
      }
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  # POST /auth/pin_login (register - employee ID + PIN, any role)
  def pin_login
    user = User.find_by(employee_id: params[:employee_id])

    if user&.authenticate_pin(params[:pin]) && user.active?
      token = JsonWebToken.encode({
        user_id: user.id,
        role: user.role,
        employee_id: user.employee_id,
        username: user.username
      })
      render json: {
        token: token,
        role: user.role,
        employee_id: user.employee_id,
        username: user.username
      }
    else
      render json: { error: "Invalid employee ID or PIN" }, status: :unauthorized
    end
  end
end
