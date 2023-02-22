class AppointmentsListQuery
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def list
    appointments = current_user.appointments.page params[:page]
    appointments = appointments.where(status: params[:status]).page params[:page] if params[:status].present?
    appointments = appointments.where(date: params[:date]).page params[:page] if params[:date].present?
    appointments
  end
end
