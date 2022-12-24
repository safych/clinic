class Appointment < ApplicationRecord
  validates_length_of :recommendation, minimum: 5, allow_blank: true

  belongs_to :doctor
  belongs_to :patient

  paginates_per 15
end
