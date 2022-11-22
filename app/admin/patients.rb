ActiveAdmin.register Patient do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

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

  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :phone, :encrypted_password, :name, :surname, :age, :gender, :residence, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
