class AppointmentsListQuery
  def initialize(current_user, search_status, page, date)
    @current_user = current_user
    @search_status = search_status
    @page = page
    @date = date
  end

  def sort
    return sort_patient_appointments if @current_user.instance_of?(::Patient)
    return sort_doctor_appointments if @current_user.instance_of?(::Doctor)
  end

  def sort_patient_appointments
    return sort_patient_appointments_by_status if @search_status.present?
    return sort_patient_appointments_by_date if @date.present?

    Appointment.where(patient_id: @current_user.id).order('id DESC').page @page
  end

  def sort_patient_appointments_by_status
    Appointment.where(patient_id: @current_user.id, status: @search_status)
               .order('id DESC').page @page
  end

  def sort_patient_appointments_by_date
    Appointment.where(patient_id: @current_user.id, date: @date.to_fs(:iso8601)).page @page
  end

  def sort_doctor_appointments
    return sort_doctor_appointments_by_status if @search_status.present?
    return sort_doctor_appointments_by_date if @date.present?

    Appointment.where(doctor_id: @current_user.id).order('id DESC').page @page
  end

  def sort_doctor_appointments_by_status
    Appointment.where(doctor_id: @current_user.id, status: @search_status).order('id DESC').page @page
  end

  def sort_doctor_appointments_by_date
    Appointment.where(doctor_id: @current_user.id, date: @date.to_fs(:iso8601)).page @page
  end
end
