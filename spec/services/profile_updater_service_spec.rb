require 'rails_helper'

RSpec.describe ProfileUpdaterService do
  describe "Updating a doctor's data" do
    before :each do
      create(:category)
      create(:doctor)
    end

    it 'return successful update' do
      doctor = Doctor.find(1)
      new_params = { name: 'Andriya', surname: 'Morgan', phone: '+380962043232' }
      result = ProfileUpdaterService.new(doctor, new_params).update
      expect(result.status).to eq true
      expect(result.notice).to eq "The doctor's data has been successfully updated"
    end

    it 'return error search doctor' do
      doctor = Doctor.new(id: 1, category_id: 1, phone: '+380962046232', name: 'Cl', surname: 'Ar',
                          encrypted_password: '1234567')
      new_params = { name: 'Andriya', surname: 'Morgan', phone: '+380962043232' }
      result = ProfileUpdaterService.new(doctor, new_params).update
      expect(result.status).to eq false
      expect(result.notice).to include('This doctor was not found')
    end

    it 'return error update' do
      doctor = Doctor.find(1)
      new_params = { name: 'A', surname: 'M', phone: '+380962043232' }
      result = ProfileUpdaterService.new(doctor, new_params).update
      expect(result.status).to eq false
      expect(result.notice).to include('Doctor data has not been updated')
    end
  end

  describe "Updating a patient's data" do
    before :each do
      create(:patient)
    end

    it 'return successful update' do
      patient = Patient.find(1)
      new_params = { name: 'Bob', surname: 'Cl', phone: '+380962043232', age: 30, gender: 'man', residence: 'rtgnjrtnjijj' }
      result = ProfileUpdaterService.new(patient, new_params).update
      expect(result.status).to eq true
      expect(result.notice).to eq "The patient's data has been successfully updated"
    end

    it 'return error search patient' do
      patient = Patient.new(id: 1, phone: '+380962043232', encrypted_password: '1234567', name: 'Bob', surname: 'Cloon',
                            age: 30, residence: nil)
      new_params = { name: 'Bob', surname: 'Cl', phone: '+380962043232', age: 30, gender: 'man', residence: 'rtgnjrtnjijj' }
      result = ProfileUpdaterService.new(patient, new_params).update
      expect(result.status).to eq false
      expect(result.notice).to include('This patient was not found')
    end

    it 'return error update' do
      patient = Patient.find(1)
      new_params = { name: 'Bob', surname: 'Cl', phone: '+380962043232', age: 30, gender: 'man', residence: 'ijj' }
      result = ProfileUpdaterService.new(patient, new_params).update
      expect(result.status).to eq false
      expect(result.notice).to include('Patient data has not been updated')
    end
  end
end
