class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :appointments
  has_many :categories

  validates :phone, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
