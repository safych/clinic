# frozen_string_literal: true

class Patients::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def edit
    super
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :phone, :age, :gender, :residence])
  end
end
