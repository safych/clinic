ActiveAdmin.register Patient do
  controller.skip_authorization_check

  controller do
    def update
      patient = Patient.find(params[:id])
      password = BCrypt::Password.create(params[:patient][:encrypted_password])
      patient.update(name: params[:patient][:name], surname: params[:patient][:surname], phone: params[:patient][:phone],
                     encrypted_password: password, age: params[:patient][:age], gender: params[:patient][:gender], 
                     residence: params[:patient][:residence])
      if patient.save!
        redirect_to admin_patients_path
        return
      else
        head 406
      end
    end
  end

  permit_params :email, :phone, :encrypted_password, :token_update, :name, :surname, :age, :gender, :residence, :reset_password_token, :reset_password_sent_at, :remember_created_at
  
  form partial: "form"

  index do
    selectable_column
    id_column
    column :phone
    column :name
    column :surname
    column :age
    column :gender
    column :residence
    actions
  end
end
