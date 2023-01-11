class DoctorUpdater < ApplicationService
  def initialize(doctor, category_id, phone, name, surname)
    @doctor = doctor
    @category_id = category_id
    @phone = phone
    @name = name
    @surname = surname
  end

  def call
    update_doctor
  end

  private

  def update_doctor
    if !@doctor.nil?
      @doctor.update(category_id: @category_id, phone: @phone, name: @name, surname: @surname)
    else
      false
    end
  end
end
