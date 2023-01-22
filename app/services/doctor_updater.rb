class DoctorUpdater < ApplicationService
  def initialize(doctor, category_id, phone, name, surname)
    @doctor = doctor
    @category_id = category_id
    @phone = phone
    @name = name
    @surname = surname
  end

  def call
    update
  end

  private

  def update
    return error_search_doctor if search_doctor.nil?
    return successful_update if check_update

    ServiceStatus.new(false, I18n.t('services.doctor_updater.not_successful_update'))
  end

  def search_doctor
    Doctor.find_by(id: @doctor.id, phone: @doctor.phone, category_id: @doctor.category_id)
  end

  def check_update
    @doctor.update(category_id: @category_id, phone: @phone, name: @name, surname: @surname)
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.doctor_updater.successful_update'))
  end

  def error_search_doctor
    ServiceStatus.new(false, I18n.t('services.doctor_updater.error_search_doctor'))
  end
end
