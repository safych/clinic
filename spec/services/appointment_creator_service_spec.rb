require 'rails_helper'

RSpec.describe AppointmentCreatorService do
  describe 'Checking an appointment with a doctor when 11 people are already registered for that day' do
    before :each do
      create(:category)
      create(:doctor)
      create(:patient)
      create(:patient, id: '2', phone: '+380931232318', name: 'Ma', surname: 'Ma')
      create(:patient, id: '3', phone: '+380931232317', name: 'Va', surname: 'Va')
      create(:patient, id: '4', phone: '+380931232316', name: 'Vl', surname: 'Vl')
      create(:patient, id: '5', phone: '+380931232315', name: 'Bo', surname: 'Bo')
      create(:patient, id: '6', phone: '+380931232314', name: 'Al', surname: 'Al')
      create(:patient, id: '7', phone: '+380931232313', name: 'Dm', surname: 'Dm')
      create(:patient, id: '8', phone: '+380931232312', name: 'Vo', surname: 'Vo')
      create(:patient, id: '9', phone: '+380931232311', name: 'Vi', surname: 'Vi')
      create(:patient, id: '10', phone: '+380931232310', name: 'Va', surname: 'Va')
      create(:patient, id: '11', phone: '+380931232329', name: 'An', surname: 'An')
      create(:patient, id: '12', phone: '+380931232323', name: 'Ro', surname: 'Ro')
      create(:appointment, id: '1', doctor_id: '1', patient_id: '2', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '2', doctor_id: '1', patient_id: '3', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '3', doctor_id: '1', patient_id: '4', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '4', doctor_id: '1', patient_id: '5', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '5', doctor_id: '1', patient_id: '6', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '6', doctor_id: '1', patient_id: '7', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '7', doctor_id: '1', patient_id: '8', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '8', doctor_id: '1', patient_id: '9', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '9', doctor_id: '1', patient_id: '10', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '10', doctor_id: '1', patient_id: '11', status: 'wait', date: '2023-01-15')
      create(:appointment, id: '11', doctor_id: '1', patient_id: '12', status: 'wait', date: '2023-01-15')
    end

    it 'Return count error' do
      new_appointment = Appointment.new(doctor_id: '1', patient_id: '1', status: 'wait', recommendation: nil,
                                        date: '2023-01-15')
      result = AppointmentCreatorService.new(new_appointment).create_appointment
      expect(result.status).to eq false
      expect(result.notice).to include('The doctor has no more places for today')
    end
  end

  describe 'Verification of an appointment for the same day with the same doctor' do
    before :each do
      create(:category)
      create(:doctor)
      create(:patient)
      create(:appointment)
    end

    it 'Return already exist error' do
      new_appointment = Appointment.new(doctor_id: '1', patient_id: '1', status: 'wait', recommendation: nil,
                                        date: '2022-12-12')
      result = AppointmentCreatorService.new(new_appointment).create_appointment
      expect(result.status).to eq false
      expect(result.notice).to include('You are currently registered with this doctor')
    end
  end

  describe 'Successful creation' do
    before :each do
      create(:category)
      create(:doctor)
      create(:patient)
      create(:appointment)
    end

    it 'Return successful save' do
      new_appointment = Appointment.new(id: '2', doctor_id: '1', patient_id: '1', status: 'wait', recommendation: nil,
                                        date: '2023-01-15')
      result = AppointmentCreatorService.new(new_appointment).create_appointment
      expect(result.status).to eq true
    end
  end
end
