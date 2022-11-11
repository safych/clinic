class PatientsController < ApplicationController
  before_action :authenticate_patient! 
  before_action :set_patient, only: [:update]

  def update
    if @patient.update(patient_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def profile
  end


  private

  def set_patient 
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.permit(:name, :surname, :phone, :age, :gender, :residence)
  end
end