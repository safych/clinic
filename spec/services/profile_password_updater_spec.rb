require 'rails_helper'

RSpec.describe ProfilePasswordUpdater do
  before :each do
    create(:category)
    create(:doctor)
    create(:patient)
  end

  it 'return sucesful update' do
    user = Doctor.find(1)
    result = ProfilePasswordUpdater.call(user, '123456', '123456')
    expect(result.status).to eq true
    expect(result.notice).to eq 'User password was successfully updated'
  end

  it 'return error length password' do
    user = Patient.find(1)
    result = ProfilePasswordUpdater.call(user, '1234', '1234')
    expect(result.status).to eq false
    expect(result.notice).to eq 'The password is too short'
  end

  it 'return error pwd confirmation' do
    user = Doctor.find(1)
    result = ProfilePasswordUpdater.call(user, '1234567', '123456')
    expect(result.status).to eq false
    expect(result.notice).to eq 'The entered passwords do not equal password confirm'
  end
end
