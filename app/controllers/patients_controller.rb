class PatientsController < ApplicationController
  load_and_authorize_resource

  def update
    updating = PatientUpdater.call(@patient, patient_params)

    if updating.status
      redirect_to profile_path, notice: updating.notice
    else
      redirect_to profile_patient_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  private

  def patient
    @patient ||= Patient.find(params[:id])
  end

  def patient_params
    params.permit(:name, :surname, :phone, :age, :gender, :residence)
  end
end
