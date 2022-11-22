class PatientsController < ApplicationController
  def update
    patient = Patient.find_by(id: params[:id], token_update: params[:token_update])
    if !patient.nil?
      patient.update(name: params[:name], surname: params[:surname], phone: params[:phone], 
                     age: params[:age], gender: params[:gender], residence: params[:residence])
      redirect_to profile_patient_path
      return
    else
      head :unprocessable_entity
    end
  end

  def profile
  end
end