class AppointmentCreator < ApplicationService
  def initialize(new_appointment)
    @new_appointment = new_appointment
  end

  def call
    create_appointment
  end

  private

  def create_appointment
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
    Appointment.find_by(patient_id: @new_appointment.patient_id, date: @new_appointment.date,
                        doctor_id: @new_appointment.doctor_id)
  end
end
