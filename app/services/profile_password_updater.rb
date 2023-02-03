class ProfilePasswordUpdater < ApplicationService
  def initialize(doctor, password, password_confirmation)
    @doctor = doctor
    @password = password
    @password_confirmation = password_confirmation
  end

  def call
    update_password
  end

  private

  def update_password
    return error_length_password if @password.to_s.length < 5
    return error_pwd_confirmation if @password != @password_confirmation
    return error_search_doctor if search_doctor.nil?
    return successful_update if check_update

    ServiceStatus.new(false, I18n.t('services.doctor_password_updater.not_successful_update'))
  end

  def check_update
    password = BCrypt::Password.create(@password)
    @doctor.update(encrypted_password: password)
  end

  def search_doctor
    Doctor.find_by(id: @doctor.id, phone: @doctor.phone)
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.doctor_password_updater.successful_update'))
  end

  def error_search_doctor
    ServiceStatus.new(false, I18n.t('services.doctor_password_updater.error_search_doctor'))
  end

  def error_length_password
    ServiceStatus.new(false, I18n.t('services.doctor_password_updater.error_length_password'))
  end

  def error_pwd_confirmation
    ServiceStatus.new(false, I18n.t('services.doctor_password_updater.error_pwd_confirmation'))
  end
end
