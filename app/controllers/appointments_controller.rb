class AppointmentsController < ApplicationController
  check_authorization unless: :devise_controller?
  load_and_authorize_resource

  def index
    @appointments = AppointmentsListQuery.new(current_user, index_params).list
  end

  def show; end

  def new
    @appointment = Appointment.new
    @doctors = Doctor.all
  end

  def edit; end

  def create
    creating = AppointmentCreatorService.new(appointment_params).create_appointment

    if creating.success?
      redirect_to appointments_path, notice: creating.notice
    else
      redirect_to appointments_path, status: :unprocessable_entity,
                                     notice: creating.notice
    end
  end

  def update
    updating = AppointmentRecommendationUpdaterService.new(appointment, params[:recommendation]).add_recommendation

    if updating.success?
      redirect_to appointment_url(appointment), notice: updating.notice
    else
      render :edit, status: :unprocessable_entity, locals: { appointment: appointment }, notice: updating.notice
    end
  end

  def destroy
    appointment.destroy!
    redirect_to appointments_url, notice: I18n.t('controllers.appointments.successful_destroy')
  end

  private

  def index_params
    params.permit(:status, :page, :date)
  end

  def appointment
    @appointment ||= Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :patient_id, :status, :recommendation, :date)
  end
end
