class UsersController < ApplicationController
  before_action :require_operator
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users (all users)
  def index
    scope = case params[:filter]
            when 'employees' then User.employees
            when 'customers' then User.customers
            else User.all
            end

    scope = scope.active_users unless params[:include_inactive] == 'true'
    render json: scope.order(:last_name, :first_name).map { |u| user_json(u) }
  end

  # GET /users/:id
  def show
    render json: user_json(@user)
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: user_json(@user), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH /users/:id
  def update
    if @user.update(user_params)
      render json: user_json(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id — soft delete, never actually destroys
  def destroy
    @user.update!(active: false)
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :phone,
      :password, :password_confirmation,
      :employee_id, :pin, :pin_confirmation,
      :pin_length, :role, :active,
      preferences: {}
    )
  end

  def user_json(user)
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      full_name: user.full_name,
      email: user.email,
      phone: user.phone,
      role: user.role,
      employee_id: user.employee_id,
      pin_length: user.pin_length,
      active: user.active,
      preferences: user.preferences,
      created_at: user.created_at
    }
  end
end
