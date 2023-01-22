class PatientUpdater < ApplicationService
  def initialize(patient, new_params)
    @patient = patient
    @new_params = new_params
  end

  def call
    update
  end

  private

  def update
    return error_search_patient if search_patient.nil?
    return successful_update if check_update

    ServiceStatus.new(false, I18n.t('services.patient_updater.not_successful_update'))
  end

  def search_patient
    Patient.find_by(id: @patient.id, phone: @patient.phone)
  end

  def error_search_patient
    ServiceStatus.new(false, I18n.t('services.patient_updater.error_search_patient'))
  end

  def check_update
    @patient.update(name: @new_params[:name], surname: @new_params[:surname], phone: @new_params[:phone],
                    age: @new_params[:age], gender: @new_params[:gender], residence: @new_params[:residence])
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.patient_updater.successful_update'))
  end
end
