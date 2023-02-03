class Patient < ApplicationRecord
  has_many :appointments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include ApplicationHelper

  validates :name, length: { minimum: 2 }
  validates :surname, length: { minimum: 2 }
  validates :residence, length: { minimum: 8, maximum: 30 }
  validates :password, allow_blank: true, length: { minimum: 6 }
  validates :password_confirmation, allow_blank: true, length: { minimum: 6 }
  validates :age, numericality: { less_than_or_equal_to: 100, only_integer: true }
  validates :phone, format: { with: self::FORMAT_NUMBER_PHONE, message: I18n.t('models.validates_phone'),
                              uniqueness: true }

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
