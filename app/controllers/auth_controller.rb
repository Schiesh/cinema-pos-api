class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :pin_login, :register, :customer_login]

  # POST /auth/login (operator panel - email + password)
  def login
    user = User.find_by(email: params[:email]&.downcase)

    if user&.authenticate(params[:password]) && user.active? && user.operator?
      token = JsonWebToken.encode({
        user_id: user.id,
        role: user.role,
        email: user.email,
        full_name: user.full_name
      })
      render json: {
        token: token,
        role: user.role,
        email: user.email,
        full_name: user.full_name
      }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # POST /auth/pin_login (register - employee_id + PIN)
  def pin_login
    user = User.find_by(employee_id: params[:employee_id])

    if user&.authenticate_pin(params[:pin]) && user.active? && user.employee?
      token = JsonWebToken.encode({
        user_id: user.id,
        role: user.role,
        employee_id: user.employee_id,
        full_name: user.full_name
      })
      render json: {
        token: token,
        role: user.role,
        employee_id: user.employee_id,
        full_name: user.full_name
      }
    else
      render json: { error: "Invalid employee ID or PIN" }, status: :unauthorized
    end
  end

  # POST /auth/register (customer self-registration on booking site)
  def register
    user = User.new(register_params)
    user.role = 'customer'
    user.active = true

    if user.save
      token = JsonWebToken.encode({
        user_id: user.id,
        role: user.role,
        email: user.email,
        full_name: user.full_name
      })
      render json: {
        token: token,
        role: user.role,
        email: user.email,
        full_name: user.full_name
      }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # POST /auth/customer_login
  def customer_login
    user = User.find_by(email: params[:email]&.downcase)

    if user&.authenticate(params[:password]) && user.active? && user.customer?
      token = JsonWebToken.encode({
        user_id: user.id,
        role: user.role,
        email: user.email,
        full_name: user.full_name
      })
      render json: {
        token: token,
        role: user.role,
        email: user.email,
        full_name: user.full_name
      }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # GET /auth/me
  def me
    user = User.find(@current_user_payload[:user_id])
    render json: {
      id: user.id,
      full_name: user.full_name,
      email: user.email,
      role: user.role
    }
  end

  private

  def register_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :phone,
      :password, :password_confirmation
    )
  end
end
