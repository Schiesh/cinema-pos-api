class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_password :pin, validations: false

  ROLES = %w[operator cashier customer].freeze

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: ROLES }
  validates :pin_length, inclusion: { in: [4, 6] }, allow_nil: true
  validates :active, inclusion: { in: [true, false] }

  validate :employee_must_have_employee_id
  validate :employee_must_have_pin
  validate :employee_or_operator_must_have_password

  scope :employees, -> { where(role: %w[operator cashier]) }
  scope :customers, -> { where(role: 'customer') }
  scope :active_users, -> { where(active: true) }

  def operator?
    role == 'operator'
  end

  def cashier?
    role == 'cashier'
  end

  def customer?
    role == 'customer'
  end

  def employee?
    operator? || cashier?
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def employee_must_have_employee_id
    if employee? && employee_id.blank?
      errors.add(:employee_id, "is required for operators and cashiers")
    end
  end

  def employee_must_have_pin
    if employee? && pin_digest.blank?
      errors.add(:pin, "is required for operators and cashiers")
    end
  end

  def employee_or_operator_must_have_password
    if (operator? || customer?) && password_digest.blank?
      errors.add(:password, "is required for operators and customers")
    end
  end
end