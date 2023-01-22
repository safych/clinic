class DoctorsController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check :index

  def index
    @doctors = DoctorsListQuery.new(params[:search_category], params[:search_surname], params[:page]).sort
  end

  def update_password
    updating = DoctorPasswordUpdater.call(doctor, params[:password], params[:password_confirmation])

    if updating.status
      redirect_to new_doctor_session_path, notice: updating.notice
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  def update_photo
    updating = DoctorPhotoUpdater.call(doctor, params[:avatar])

    if updating.status
      redirect_to profile_path, notice: updating.notice
    else
      redirect_to profile_doctor_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  def update
    updating = DoctorUpdater.call(@doctor, params[:category_id], params[:phone], params[:name], params[:surname])

    if updating.status
      redirect_to profile_path, notice: updating.notice
    else
      redirect_to profile_doctor_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  private

  def doctor
    @doctor ||= Doctor.find(params[:id])
  end
end
