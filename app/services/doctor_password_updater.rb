class DoctorPasswordUpdater < ApplicationService
  def initialize(doctor, password, password_confirmation)
    @doctor = doctor
    @password = password
    @password_confirmation = password_confirmation
  end

  def call
    update_password
  end

  private

  def update_password
    if !@doctor.nil? && check_password
      password = BCrypt::Password.create(@password)
      @doctor.update(encrypted_password: password)
      true
    else
      false
    end
  end

  def check_password
    if @password.to_s.length > 5 && @password === @password_confirmation
      true
    else
      false
    end
  end
end