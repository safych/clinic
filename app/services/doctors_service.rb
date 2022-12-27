class DoctorsService
  def initialize(doctor, password, password_confirmation, avatar, category_id, phone, name, surname)
    @doctor = doctor
    @password = password
    @password_confirmation = password_confirmation
    @avatar = avatar
    @category_id = category_id
    @phone = phone
    @name = name
    @surname = surname
  end

  def update
    if !@doctor.nil?
      @doctor.update(category_id: @category_id, phone: @phone, name: @name, surname: @surname)
      redirect_to profile_path, notice: "Doctor was successfully updated."
    else
      redirect_to profile_doctor_path, status: :unprocessable_entity
    end
  end

  def update_password
    if !@doctor.nil? && check_password
      password = BCrypt::Password.create(@password)
      doctor.update(encrypted_password: password)
      redirect_to new_doctor_session_path, notice: "Doctor password was successfully updated."
    else
      redirect_to profile_path, status: :unprocessable_entity, notice: "Doctor password wasn't successfully updated." 
    end
  end

  def check_password
    if @password.to_s.length > 5 && @password === @password_confirmation
      true
    else
      false
    end
  end

  def update_photo
    if !@doctor.nil?
      @doctor.avatar.attach(@avatar)
      redirect_to profile_path, notice: "Doctor avatar was successfully updated."
    else
      redirect_to profile_doctor_path, status: :unprocessable_entity
    end
  end
end