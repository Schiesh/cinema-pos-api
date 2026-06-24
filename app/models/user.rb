class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_password :pin, validations: false

  ROLES = %w[operator cashier].freeze

  validates :role, inclusion: { in: ROLES }
  validates :username, uniqueness: true, allow_blank: true
  validates :employee_id, presence: true, uniqueness: true
  validates :pin_length, inclusion: { in: [4, 6] }

  validate :operator_must_have_username
  validate :operator_must_have_password

  def operator?
    role == 'operator'
  end

  def cashier?
    role == 'cashier'
  end

  private

  def operator_must_have_username
    if operator? && username.blank?
      errors.add(:username, "is required for operators")
    end
  end

  def operator_must_have_password
    if operator? && password_digest.blank?
      errors.add(:password, "is required for operators")
    end
  end
end