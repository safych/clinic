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
  validates :phone, uniqueness: true, format: { with: self::FORMAT_NUMBER_PHONE, message: "Incorrectly entered phone number" }

  paginates_per 5

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
