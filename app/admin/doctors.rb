require 'securerandom'

ActiveAdmin.register Doctor do
  controller.load_and_authorize_resource
  
  controller do
    def create
      @doctor = Doctor.new(doctor_params)
      @doctor.token_update = SecureRandom.hex(6)
      if @doctor.save!
        redirect_to admin_doctors_path
        return
      else
        head 406
      end
    end

    def update
      doctor = Doctor.find(params[:id])
      password = BCrypt::Password.create(params[:doctor][:encrypted_password])
      doctor.update(category_id: params[:doctor][:category_id], name: params[:doctor][:name], surname: params[:doctor][:surname], 
                    phone: params[:doctor][:phone], encrypted_password: password)
      if doctor.save!
        redirect_to admin_doctors_path
        return
      else
        head 406
      end
    end
    
    private
  
    def doctor_params
      params.require(:doctor).permit(:category_id, :name, :surname, :phone, :password, :password_confirmation)
    end
  end

  index do
    selectable_column
    id_column
    column :phone
    column :name
    column :surname
    column "Category" do |c|
      categor = Category.find(c.category_id).title
    end
    actions
  end

  permit_params :category_id, :email, :token_update, :phone, :name, :surname, :encrypted_password, :token_update, :reset_password_token, :reset_password_sent_at, :remember_created_at

  form partial: "form"


  #
  # or
  #
  # permit_params do
  #   permitted = [:category_id, :email, :phone, :encrypted_password, :name, :surname, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_admin_user
  #   permitted
  # end
  
end
