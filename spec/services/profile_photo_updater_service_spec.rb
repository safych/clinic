require 'rails_helper'

RSpec.describe ProfilePhotoUpdaterService do
  before :each do
    create(:category)
    create(:doctor)
  end

  it 'return error search doctor' do
    doctor = Doctor.new(id: 1, category_id: 1, phone: '+380962043232', name: 'Cl', surname: 'Ar',
                        encrypted_password: '1234567')
    result = ProfilePhotoUpdaterService.new(doctor, 'image.jpg').update_photo
    expect(result.status).to eq false
    expect(result.notice).to include('This doctor was not found')
  end
end
