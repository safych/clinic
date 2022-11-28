ActiveAdmin.register Appointment do
  controller.skip_authorization_check

  permit_params :doctor_id, :patient_id, :status, :recommendation, :date
end
