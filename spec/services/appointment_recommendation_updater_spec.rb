require 'rails_helper'

RSpec.describe AppointmentRecommendationUpdater do
  before :each do
    create(:category)
    create(:doctor)
    create(:patient)
  end

  it 'return successful update' do
    appointment = Appointment.new(doctor_id: '1', patient_id: '1', status: 'wait', recommendation: nil,
                                  date: '2023-01-15')
    result = AppointmentRecommendationUpdater.call(appointment, 'Hello world')
    expect(result.status).to eq true
    expect(result.notice).to eq 'Appointment was successfully added to the recommendation'
  end

  it 'return error recommendation' do
    appointment = Appointment.new(doctor_id: '1', patient_id: '1', status: 'wait', recommendation: nil,
                                  date: '2023-01-15')
    result = AppointmentRecommendationUpdater.call(appointment, 'Hel')
    expect(result.status).to eq false
    expect(result.notice).to eq 'Short recommendation is less than 5 characters'
  end
end
