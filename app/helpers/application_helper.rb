module ApplicationHelper
  FORMAT_NUMBER_PHONE = /\A\+?380[345679]\d{8}\z/
  
  def doctor_avatar(doctor, size=40)
    if doctor.avatar.attached?
      doctor.avatar.key
    else
      "149071_qgovwv"
    end
  end
end
