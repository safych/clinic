require 'rails_helper'

RSpec.describe ProfilePasswordUpdaterService do
  before :each do
    create(:category)
    create(:doctor)
    create(:patient)
  end

  it 'return sucesful update' do
    user = Doctor.find(1)
    params = { password: '123456', password_confirmation: '123456' }
    result = ProfilePasswordUpdaterService.new(user, params).update_password
    expect(result.status).to eq true
    expect(result.notice).to eq 'User password was successfully updated'
  end

  it 'return error length password' do
    user = Patient.find(1)
    params = { password: '1234', password_confirmation: '1234' }
    result = ProfilePasswordUpdaterService.new(user, params).update_password
    expect(result.status).to eq false
    expect(result.notice).to include('The password is too short')
  end

  it 'return error pwd confirmation' do
    user = Doctor.find(1)
    params = { password: '123456', password_confirmation: '1234567' }
    result = ProfilePasswordUpdaterService.new(user, params).update_password
    expect(result.status).to eq false
    expect(result.notice).to include('The entered passwords do not equal password confirm')
  end
end
