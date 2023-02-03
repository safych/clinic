ActiveAdmin.register Category do
  controller.skip_authorization_check

  permit_params :title

  actions :all, except: :destroy
end
