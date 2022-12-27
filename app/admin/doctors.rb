ActiveAdmin.register Doctor do
  controller.skip_authorization_check
  
  controller do
    def create
      @doctor = Doctor.new(doctor_params)
      @doctor.avatar.attach(params[:avatar])
      if @doctor.save!
        redirect_to admin_doctors_path
        return
      else
        head 406
      end
    end

    def update
      doctor = Doctor.find(params[:id])
      doctor.avatar.attach(params[:avatar])
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
      params.require(:doctor).permit(:category_id, :avatar, :name, :surname, :phone, :password, :password_confirmation)
    end
  end

  index do
    selectable_column
    id_column
    column :phone
    column :name
    column :surname
    column "Category" do |c|
      Category.find(c.category_id).title unless c.category_id.nil?
    end
    actions
  end


  permit_params :category_id, :email, :avatar, :phone, :name, :surname, :encrypted_password, :reset_password_token, 
                :reset_password_sent_at, :remember_created_at

  form partial: "form"
end
