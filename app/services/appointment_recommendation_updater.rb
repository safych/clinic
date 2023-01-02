class AppointmentRecommendationUpdater < ApplicationService
  def initialize(appointment, recomendation)
    @appointment = appointment
    @recomendation = recomendation
  end

  def call
    add_recommendation
  end

  private

  def add_recommendation
    if @appointment.update(recommendation: @recommendation, status: 'done')
      true
    else
      false
    end
  end
end