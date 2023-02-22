class ProfileUpdaterService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def update
    return update_doctor if @user.instance_of?(::Doctor)
    return updater_patient if @user.instance_of?(::Patient)
  end

  # Doctor

  def update_doctor
    @service_status_error = ServiceStatus.new(false, [])
    error_search_doctor if search_doctor.nil?
    return successful_update_doctor if check_update_doctor && @service_status_error.notice.empty?

    @service_status_error.notice.push(I18n.t('services.doctor_updater.not_successful_update'))
    @service_status_error
  end

  def search_doctor
    Doctor.find_by(id: @user.id, phone: @user.phone)
  end

  def check_update_doctor
    @user.update(category_id: @params[:category_id], phone: @params[:phone], name: @params[:name],
                 surname: @params[:surname])
  end

  def successful_update_doctor
    ServiceStatus.new(true, I18n.t('services.doctor_updater.successful_update'))
  end

  def error_search_doctor
    @service_status_error.notice.push(I18n.t('services.doctor_updater.error_search_doctor'))
  end

  # Patient

  def updater_patient
    @service_status_error = ServiceStatus.new(false, [])
    error_search_patient if search_patient.nil?
    return successful_update_patient if check_update_patient && @service_status_error.notice.empty?

    @service_status_error.notice.push(I18n.t('services.patient_updater.not_successful_update'))
    @service_status_error
  end

  def search_patient
    Patient.find_by(id: @user.id, phone: @user.phone)
  end

  def error_search_patient
    @service_status_error.notice.push(I18n.t('services.patient_updater.error_search_patient'))
  end

  def check_update_patient
    @user.update(name: @params[:name], surname: @params[:surname], phone: @params[:phone],
                 age: @params[:age], gender: @params[:gender], residence: @params[:residence])
  end

  def successful_update_patient
    ServiceStatus.new(true, I18n.t('services.patient_updater.successful_update'))
  end
end
