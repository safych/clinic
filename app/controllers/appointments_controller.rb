class AppointmentsController < ApplicationController
  check_authorization unless: :devise_controller?
  load_and_authorize_resource

  def index
    @appointments = AppointmentsListQuery.new(current_user, params[:search_status], params[:page],
                                              params_date_index).list
  end

  def show; end

  def new
    @appointment = Appointment.new
    @doctors = Doctor.all
  end

  def edit; end

  def create
    creating = AppointmentCreator.call(appointment_params)

    if creating.success?
      redirect_to appointments_path, notice: creating.notice
    else
      redirect_to appointments_path, status: :unprocessable_entity,
                                     notice: creating.notice
    end
  end

  def update
    updating = AppointmentRecommendationUpdater.call(appointment, params[:recommendation])

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

  def params_date_index
    return if params['search_date(1i)'].nil?

    Date.new(params['search_date(1i)'].to_i, params['search_date(2i)'].to_i, params['search_date(3i)'].to_i)
        .to_fs(:iso8601)
  end

  def appointment
    @appointment ||= Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :patient_id, :status, :recommendation, :date)
  end
end
