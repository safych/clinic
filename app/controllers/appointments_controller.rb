class AppointmentsController < ApplicationController
  load_and_authorize_resource

  def index
    @appointments = AppointmentsListQuery.new(current_user, params[:search_status], params[:page],
                                              params_date_index).sort
  end

  def show; end

  def new
    @appointment = Appointment.new
    @doctors = Doctor.where.not(category_id: nil)
  end

  def create
    creating = AppointmentCreator.call(Appointment.new(appointment_params))

    if creating
      redirect_to appointments_path, notice: 'Appointment was successfully created.'
    else
      redirect_to appointments_path, status: :unprocessable_entity,
                                     notice: "Appointment wasn't successfully created. Because the doctor has no more
                                     places for today or you have already booked an appointment."
    end
  end

  def edit; end

  def edit_recommendation
    updating = AppointmentRecommendationUpdater.call(appointment, params[:recommendation])

    if updating
      redirect_to appointment_url(appointment), notice: 'Appointment was successfully added to the recommendation.'
    else
      render :edit, status: :unprocessable_entity, locals: { appointment: appointment }
    end
  end

  def destroy
    appointment.destroy
    redirect_to appointments_url, notice: 'Appointment was successfully destroyed.'
  end

  private

  def params_date_index
    return unless params['search_date(1i)'].present?

    Date.new(params['search_date(1i)'].to_i, params['search_date(2i)'].to_i, params['search_date(3i)'].to_i)
  end

  def appointment
    @appointment ||= Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :patient_id, :status, :recommendation, :date)
  end
end
