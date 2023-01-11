class PatientUpdater < ApplicationService
  def initialize(id, name, surname, phone, age, gender, residence)
    @id = id
    @name = name
    @surname = surname
    @phone = phone
    @age = age
    @gender = gender
    @residence = residence
  end

  def call
    update_patient
  end

  private

  def update_patient
    patient = Patient.find_by(id: @id)
    if !patient.nil?
      patient.update(name: @name, surname: @surname, phone: @phone, age: @age, gender: @gender, residence: @residence)
    else
      false
    end
  end
end
