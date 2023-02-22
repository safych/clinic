class AppointmentRecommendationUpdaterService
  def initialize(appointment, recommendation)
    @appointment = appointment
    @recommendation = recommendation
  end

  def add_recommendation
    @service_status_error = ServiceStatus.new(false, [])
    error_recommendation if @recommendation.length < 5
    return successful_update if check_update && @service_status_error.notice.empty?

    @service_status_error.notice.push(I18n.t('services.appointment_recommendation_updater.not_successful_update'))
    @service_status_error
  end

  def error_recommendation
    @service_status_error.notice.push(I18n.t('services.appointment_recommendation_updater.error_recommendation'))
  end

  def check_update
    @appointment.update(recommendation: @recommendation, status: 'done')
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.appointment_recommendation_updater.successful_update'))
  end
end
