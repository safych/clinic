class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[update_password update_photo update]
  load_and_authorize_resource
  skip_authorization_check :index

  def index
    @doctors = DoctorsListQuery.call(params[:search_category], params[:search_surname], params[:page])
  end

  def update_password
    check = DoctorPasswordUpdater.call(@doctor, params[:password], params[:password_confirmation])

    if check
      redirect_to new_doctor_session_path, notice: "Doctor password was successfully updated."
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: "Doctor password wasn't successfully updated." 
    end
  end

  def update_photo
    check = DoctorPhotoUpdater.call(@doctor, params[:avatar])

    if check
      redirect_to profile_path, notice: "Doctor avatar was successfully updated."
    else
      redirect_to profile_doctor_path, status: :unprocessable_entity
    end
  end

  def update
    check = DoctorUpdater.call(@doctor, params[:category_id], params[:phone], params[:name], params[:surname])
    
    if check
      redirect_to profile_path, notice: "Doctor was successfully updated."
    else
      redirect_to profile_doctor_path, status: :unprocessable_entity
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
