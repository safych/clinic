class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :appointments
  
  validates_length_of :name, minimum: 2, allow_blank: true
  validates_length_of :surname, minimum: 2, allow_blank: true
  validates_length_of :residence, minimum: 8, maximum: 30, allow_blank: true
  validates :phone, uniqueness: true, length: {is: 13}, allow_blank: true

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
