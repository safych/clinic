require 'rails_helper'

RSpec.describe DoctorPasswordUpdater do
  before :each do
    create(:category)
    create(:doctor)
  end

  it 'return sucesful update' do
    doctor = Doctor.find(1)
    result = DoctorPasswordUpdater.call(doctor, '123456', '123456')
    expect(result.status).to eq true
    expect(result.notice).to eq 'Doctor password was successfully updated'
  end

  it 'return error search doctor' do
    doctor = Doctor.new(id: 1, category_id: 1, phone: '+380962043232', name: 'Cl', surname: 'Ar', encrypted_password: '1234567')
    result = DoctorPasswordUpdater.call(doctor, '123456', '123456')
    expect(result.status).to eq false
    expect(result.notice).to eq 'This doctor was not found'
  end

  it 'return error length password' do
    doctor = Doctor.find(1)
    result = DoctorPasswordUpdater.call(doctor, '1234', '1234')
    expect(result.status).to eq false
    expect(result.notice).to eq 'The password is too short'
  end

  it 'return error pwd confirmation' do
    doctor = Doctor.find(1)
    result = DoctorPasswordUpdater.call(doctor, '1234567', '123456')
    expect(result.status).to eq false
    expect(result.notice).to eq 'The entered passwords do not equal password confirm'
  end
end