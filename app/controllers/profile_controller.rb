class ProfileController < ApplicationController
  check_authorization unless: :devise_controller?
  load_and_authorize_resource

  def show; end

  def update
    @updating = ProfileUpdaterService.new(current_user, update_params).update

    update_notice
  end

  def update_photo
    @updating = ProfilePhotoUpdaterService.new(current_user, params[:avatar]).update_photo

    update_notice
  end

  def update_password
    updating = ProfilePasswordUpdaterService.new(current_user, update_password_params).update_password

    if updating.success?
      redirect_to new_patient_session_path, notice: updating.notice
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: updating.notice
    end
  end

  def update_notice
    if @updating.success?
      redirect_to profile_path, notice: @updating.notice
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: @updating.notice
    end
  end

  private

  def update_password_params
    params.permit(:password, :password_confirmation)
  end

  def update_params
    params.permit(:name, :surname, :phone, :age, :gender, :residence, :category_id)
  end
end
