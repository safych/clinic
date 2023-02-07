class ProfileController < ApplicationController
  check_authorization unless: :devise_controller?
  load_and_authorize_resource

  def show; end

  def update
    updating = ProfileUpdater.call(current_user, update_params)

    if updating.success?
      redirect_to profile_path, notice: updating.notice
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  def update_photo
    updating = ProfilePhotoUpdater.call(current_user, params[:avatar])

    if updating.success?
      redirect_to profile_path, notice: updating.notice
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  def update_password
    updating = ProfilePasswordUpdater.call(current_user, params[:password], params[:password_confirmation])

    if updating.success?
      redirect_to new_patient_session_path, notice: updating.notice
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  private

  def update_params
    params.permit(:name, :surname, :phone, :age, :gender, :residence, :category_id)
  end
end
