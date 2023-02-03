class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  before_action :set_locale

  def configure_permitted_parameters
    update_attrs = %i[password password_confirmation current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  private

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def current_user
    @current_user ||=
      if patient_signed_in?
        current_patient
      elsif doctor_signed_in?
        current_doctor
      elsif admin_user_signed_in?
        current_admin_user
      end
  end
end
