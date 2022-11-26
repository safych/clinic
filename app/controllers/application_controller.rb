class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  check_authorization unless: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  # rescue_from CanCan::AccessDenied do |exception|
  #   if current_user.nil?
  #     session[:next] = request.fullpath
  #     redirect_to login_url, alert: 'You have to log in to continue.'
  #   else
  #     respond_to do |format|
  #       format.json { render nothing: true, status: :not_found }
  #       format.html { redirect_to main_app.root_url, alert: exception.message }
  #       format.js   { render nothing: true, status: :not_found }
  #     end
  #   end
  # end

  private
  
  def current_user
    if patient_signed_in?
      @current_user ||= Patient.find(current_patient.id)
    elsif doctor_signed_in?
      @current_user ||= Doctor.find(current_doctor.id)
    elsif admin_user_signed_in?
      @current_user ||= Doctor.find(current_admin_user.id)
    end
  end
end
