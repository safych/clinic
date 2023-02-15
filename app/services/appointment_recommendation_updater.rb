class AppointmentRecommendationUpdater < ApplicationService
  def initialize(appointment, recommendation)
    @appointment = appointment
    @recommendation = recommendation
  end

  def call
    add_recommendation
  end

  private

  def add_recommendation
    return error_recommendation if @recommendation.length < 5
    return successful_update if check_update

    ServiceStatus.new(false, I18n.t('services.appointment_recommendation_updater.not_successful_update'))
  end

  def error_recommendation
    ServiceStatus.new(false, I18n.t('services.appointment_recommendation_updater.error_recommendation'))
  end

  def check_update
    @appointment.update(recommendation: @recommendation, status: 'done')
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.appointment_recommendation_updater.successful_update'))
  end
end
