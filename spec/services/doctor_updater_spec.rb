require 'rails_helper'

RSpec.describe DoctorUpdater do
  before :each do
    create(:category)
    create(:doctor)
  end

  it 'return successful update' do
    doctor = Doctor.find(1)
    result = DoctorUpdater.call(doctor, '1', '+380962043239', 'Andriya', 'Morgan')
    expect(result.status).to eq true
    expect(result.notice).to eq "The doctor's data has been successfully updated"
  end

  it 'return error search doctor' do
    doctor = Doctor.new(id: 1, category_id: 1, phone: '+380962043232', name: 'Cl', surname: 'Ar',
                        encrypted_password: '1234567')
    result = DoctorUpdater.call(doctor, '1', '+380962043239', 'Andriya', 'Morgan')
    expect(result.status).to eq false
    expect(result.notice).to eq 'This doctor was not found'
  end

  it 'return error update' do
    doctor = Doctor.find(1)
    result = DoctorUpdater.call(doctor, '1', '+380962043239', 'A', 'M')
    expect(result.status).to eq false
    expect(result.notice).to eq 'Doctor data has not been updated'
  end
end
