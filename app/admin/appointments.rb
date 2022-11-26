ActiveAdmin.register Appointment do

  controller.load_and_authorize_resource

  permit_params :doctor_id, :patient_id, :status, :recommendation, :date
end
