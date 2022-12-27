class AppointmentsService
  def initialize(new_appointment, patient_id, doctor_id, appointment, recommendation)
    @new_appointment = new_appointment
    @patient_id = patient_id
    @doctor_id = doctor_id
    @appointment = appointment
    @recommendation = recommendation
  end

  def create
    if count_appointments.length < 11 && verification_date.nil?
      @new_appointment.save
      true
    else
      false
    end
  end

  def count_appointments
    Appointment.where(doctor_id: @new_appointment.doctor_id, date: @new_appointment.date, status: 'wait')
  end

  def verification_date
    Appointment.find_by(patient_id: @patient_id, date: @new_appointment.date, doctor_id: @doctor_id)
  end

  def add_recommendation
    if @appointment.update(recommendation: @recommendation, status: 'done')
      true
    else
      false
    end
  end
end