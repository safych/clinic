class PatientsController < ApplicationController
  load_and_authorize_resource

  def update
    check = PatientUpdater.call(params[:id], params[:name], params[:surname], params[:phone], params[:age],
                                params[:gender], params[:residence])

    if check
      redirect_to profile_path
      nil
    else
      head :unprocessable_entity
    end
  end
end
