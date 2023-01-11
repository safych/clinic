class AppointmentsListQuery
  def initialize(current_user, search_status, page, date)
    @current_user = current_user
    @search_status = search_status
    @page = page
    @date = date
  end

  def sort
    if @current_user.instance_of?(::Patient)
      sort_patient_appointments
    elsif @current_user.instance_of?(::Doctor)
      sort_doctor_appointments
    end
  end

  def sort_patient_appointments
    if @search_status.present?
      sort_patient_appointments_by_status
    elsif @date.present?
      sort_patient_appointments_by_date
    else
      Appointment.where(patient_id: @current_user.id).order('id DESC').page @page
    end
  end

  def sort_patient_appointments_by_status
    Appointment.where(patient_id: @current_user.id, status: @search_status)
               .order('id DESC').page @page
  end

  def sort_patient_appointments_by_date
    Appointment.where(patient_id: @current_user.id, date: @date.to_fs(:iso8601)).page @page
  end

  def sort_doctor_appointments
    if @search_status.present?
      sort_doctor_appointments_by_status
    elsif @date.present?
      sort_doctor_appointments_by_date
    else
      Appointment.where(doctor_id: @current_user.id).order('id DESC').page @page
    end
  end

  def sort_doctor_appointments_by_status
    Appointment.where(doctor_id: @current_user.id, status: @search_status).order('id DESC').page @page
  end

  def sort_doctor_appointments_by_date
    Appointment.where(doctor_id: @current_user.id, date: @date.to_fs(:iso8601)).page @page
  end
end
