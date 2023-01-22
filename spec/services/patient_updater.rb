require 'rails_helper'

RSpec.describe PatientUpdater do
  before :each do
    create(:patient)
  end

  it 'return successful update' do
    patient = Patient.find(1)
    new_params = { name: 'Bob', surname: 'Cl', phone: '+380962043232', age: 30, gender: 'man', residence: 'rtgnjrtnjijj' }
    result = PatientUpdater.call(patient, new_params)
    expect(result.status).to eq true
    expect(result.notice).to eq "The patient's data has been successfully updated"
  end

  it 'return error search patient' do
    patient = Patient.new(id: 1, phone: '+380962043232', encrypted_password: '1234567', name: 'Bob', surname: 'Cloon',
                          age: 30, residence: nil)
    new_params = { name: 'Bob', surname: 'Cl', phone: '+380962043232', age: 30, gender: 'man', residence: 'rtgnjrtnjijj' }
    result = PatientUpdater.call(patient, new_params)
    expect(result.status).to eq false
    expect(result.notice).to eq 'This patient was not found'
  end

  it 'return error update' do
    patient = Patient.find(1)
    new_params = { name: 'Bob', surname: 'Cl', phone: '+380962043232', age: 30, gender: 'man', residence: 'ijj' }
    result = PatientUpdater.call(patient, new_params)
    expect(result.status).to eq false
    expect(result.notice).to eq 'Patient data has not been updated'
  end
end
