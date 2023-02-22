require 'rails_helper'

RSpec.describe AppointmentRecommendationUpdaterService do
  before :each do
    create(:category)
    create(:doctor)
    create(:patient)
  end

  it 'return successful update' do
    appointment = Appointment.new(doctor_id: '1', patient_id: '1', status: 'wait', recommendation: nil,
                                  date: '2023-01-15')
    result = AppointmentRecommendationUpdaterService.new(appointment, 'Hello world').add_recommendation
    expect(result.status).to eq true
    expect(result.notice).to eq 'Appointment was successfully added to the recommendation'
  end

  it 'return error recommendation' do
    appointment = Appointment.new(doctor_id: '1', patient_id: '1', status: 'wait', recommendation: nil,
                                  date: '2023-01-15')
    result = AppointmentRecommendationUpdaterService.new(appointment, 'Hel').add_recommendation
    expect(result.status).to eq false
    expect(result.notice).to include('Short recommendation is less than 5 characters')
  end
end
