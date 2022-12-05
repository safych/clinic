module ApplicationHelper
  def doctor_avatar(doctor, size=40)
    if doctor.avatar.attached?
      doctor.avatar.key
    else
      "149071_qgovwv"
    end
  end
end
