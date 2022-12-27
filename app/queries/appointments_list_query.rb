class AppointmentsListQuery
  def initialize(current_user, search_status, page, date)
    @current_user = current_user
    @search_status = search_status
    @page = page
    @date = date
  end

  def show
    if @current_user.instance_of?(::Patient)
      search_patient
    elsif @current_user.instance_of?(::Doctor)
      search_doctor
    end
  end

  def search_patient
    if @search_status.present?
      @appointments = Appointment.where(patient_id: @current_user.id, status: @search_status)
                                 .order('id DESC').page @page
    elsif @date.present?
      @appointments = Appointment.where(patient_id: @current_user.id, date: @date.to_fs(:iso8601)).page @page
    else
      @appointments = Appointment.where(patient_id: @current_user.id).order('id DESC').page @page
    end
  end

  def search_doctor
    if @search_status.present?
      @appointments = Appointment.where(doctor_id: @current_user.id, status: @search_status).order('id DESC').page @page
    elsif @date.present?
      @appointments = Appointment.where(doctor_id: @current_user.id, date: @date.to_fs(:iso8601)).page @page
    else
      @appointments = Appointment.where(doctor_id: @current_user.id).order('id DESC').page @page
    end
  end
end