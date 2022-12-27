class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :recommendation, allow_blank: true, length: { minimum: 5 }

  paginates_per 15
end
