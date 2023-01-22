class DoctorPhotoUpdater < ApplicationService
  def initialize(doctor, avatar)
    @doctor = doctor
    @avatar = avatar
  end

  def call
    update_photo
  end

  private

  def update_photo
    return error_search_doctor if search_doctor.nil?
    return successful_update if @doctor.avatar.attach(@avatar)

    ServiceStatus.new(false, I18n.t('services.doctor_photo_updater.not_successful_update'))
  end

  def search_doctor
    Doctor.find_by(id: @doctor.id, phone: @doctor.phone)
  end

  def error_search_doctor
    ServiceStatus.new(false, I18n.t('services.doctor_photo_updater.error_search_doctor'))
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.doctor_photo_updater.successful_update'))
  end
end
