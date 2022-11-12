ActiveAdmin.register Patient do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :phone, :encrypted_password, :name, :surname, :age, :gender, :residence, :reset_password_token, :reset_password_sent_at, :remember_created_at
  
  form do |f|
    f.inputs do
      f.input :phone
      f.input :name
      f.input :surname
      f.input :age
      f.input :gender, as: :select, collection: (["man", "women"])
      f.input :residence
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :phone, :encrypted_password, :name, :surname, :age, :gender, :residence, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
