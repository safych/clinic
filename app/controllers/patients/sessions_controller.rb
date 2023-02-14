# frozen_string_literal: true

class Patients::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  rescue
    flash[:notice] = "Error: Incorrect password or phone number!"
    redirect_to new_patient_session_path
  end
end
