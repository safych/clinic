class DoctorPhotoUpdater < ApplicationService
  def initialize(doctor, avatar)
    @doctor = doctor
    @avatar = avatar
  end

  def call
    update_photo
  end

  private

  def update_photo
    if !@doctor.nil?
      @doctor.avatar.attach(@avatar)
      true
    else
      false
    end
  end
end