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
    @appointment.update(recommendation: @recommendation, status: 'done')
  end
end
