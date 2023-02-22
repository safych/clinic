class AppointmentCreatorService
  def initialize(params)
    @params = params
  end

  def create_appointment
    @service_status_error = ServiceStatus.new(false, [])
    count_error if count_appointments.length > 10
    already_exist_error if already_booked
    return successful_save if new_appointment.save && @service_status_error.notice.empty?

    @service_status_error.notice.push(I18n.t('services.appointment_creator.not_successful_save'),
                                      new_appointment.errors.full_messages)
    @service_status_error
  end

  def new_appointment
    Appointment.new(doctor_id: @params.doctor_id, patient_id: @params.patient_id, status: @params.status,
                    recommendation: nil, date: @params.date)
  end

  def count_appointments
    Appointment.where(doctor_id: @params.doctor_id, date: @params.date)
  end

  def count_error
    @service_status_error.notice.push(I18n.t('services.appointment_creator.count_error'))
  end

  def already_booked
    Appointment.exists?(patient_id: @params.patient_id, date: @params.date,
                        doctor_id: @params.doctor_id)
  end

  def already_exist_error
    @service_status_error.notice.push(I18n.t('services.appointment_creator.already_exist_error'))
  end

  def successful_save
    ServiceStatus.new(true, I18n.t('services.appointment_creator.successful_save'))
  end
end
