class Doctor < ApplicationRecord
  belongs_to :category, optional: true
  has_many :appointments
  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include ApplicationHelper

  validates :name, length: { minimum: 2 }
  validates :surname, length: { minimum: 2 }
  validates :encrypted_password, allow_blank: true, length: { minimum: 6 }
  validates :password, allow_blank: true, length: { minimum: 6 }
  validates :password_confirmation, allow_blank: true, length: { minimum: 6 }
  validates :phone, format: { with: self::FORMAT_NUMBER_PHONE, message: I18n.t('models.validates_phone'),
                              uniqueness: true }

  paginates_per 5

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
