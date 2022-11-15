ActiveAdmin.register Doctor do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  # permitted_params

  controller do
    def create
      @doctor = Doctor.new(doctor_params)
      if @doctor.save!
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

  permit_params :category_id, :email, :phone, :name, :surname, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at

  form do |f|
    f.inputs do
      f.input :category_id, as: :select, collection: Category.all
      f.input :phone
      f.input :name
      f.input :surname
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end


  #
  # or
  #
  # permit_params do
  #   permitted = [:category_id, :email, :phone, :encrypted_password, :name, :surname, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_admin_user
  #   permitted
  # end
  
end
