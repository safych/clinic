class DoctorsController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check :index

  def index
    @doctors = Doctor.all
    if params[:search_category].present?
      @doctors = Doctor.where(category_id: params[:search_category])
    elsif params[:search_surname].present?
      @doctors = Doctor.where(surname: params[:search_surname])
    end 
  end

  def profile
  end

  def edit_password
    doctor = Doctor.find_by(id: params[:id], token_update: params[:token_update])
    respond_to do |format|
      if !doctor.nil? && check_password
        password = BCrypt::Password.create(params[:password])
        doctor.update(encrypted_password: password)
        format.html { redirect_to new_doctor_session_path, notice: "Doctor password was successfully updated." }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { 
          redirect_to profile_doctor_path, 
          status: :unprocessable_entity, 
          notice: "Doctor password wasn't successfully updated." 
        }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_photo
    doctor = Doctor.find_by(id: params[:id], token_update: params[:token_update])
    respond_to do |format|
      if !doctor.nil?
        doctor.avatar.attach(params[:avatar])
        format.html { redirect_to profile_doctor_path, notice: "Doctor avatar was successfully updated." }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { redirect_to profile_doctor_path, status: :unprocessable_entity }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_password
    if params[:password].to_s.length > 5 && params[:password] === params[:password_confirmation]
      true
    else
      false
    end
  end

  def update
    doctor = Doctor.find_by(id: params[:id], token_update: params[:token_update])
    respond_to do |format|
      if !doctor.nil?
        doctor.update(category_id: params[:category_id], phone: params[:phone], name: params[:name], surname: params[:surname])
        format.html { redirect_to profile_doctor_path, notice: "Doctor was successfully updated." }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { redirect_to profile_doctor_path, status: :unprocessable_entity }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def doctor_params
    params.require(:category).permit(:phone, :name, :surname, :category_id)
  end
end