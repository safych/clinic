class Doctor < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :appointments
  belongs_to :category

  validates_length_of :name, minimum: 2
  validates_length_of :surname, minimum: 2
  validates_length_of :encrypted_password, minimum: 6, allow_blank: true
  validates_length_of :password, minimum: 6, allow_blank: true
  validates_length_of :password_confirmation, minimum: 6, allow_blank: true
  validates :phone, uniqueness: true, format: { with: /\A\+?380[345679]\d{8}\z/, message: "Incorrectly entered phone number" } 

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
