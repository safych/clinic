class ProfilePhotoUpdaterService
  def initialize(doctor, avatar)
    @doctor = doctor
    @avatar = avatar
  end

  def update_photo
    @service_status_error = ServiceStatus.new(false, [])
    error_search_doctor if search_doctor.nil?
    return successful_update if @service_status_error.notice.empty? && @doctor.avatar.attach(@avatar)

    @service_status_error.notice.push(I18n.t('services.doctor_photo_updater.not_successful_update'))
    @service_status_error
  end

  def search_doctor
    Doctor.find_by(id: @doctor.id, phone: @doctor.phone)
  end

  def error_search_doctor
    @service_status_error.notice.push(I18n.t('services.doctor_photo_updater.error_search_doctor'))
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.doctor_photo_updater.successful_update'))
  end
end
