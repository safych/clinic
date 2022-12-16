Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: "welcome#index"
  end

  ActiveAdmin::Devise.config[:controllers][:sessions] = 'admin/sessions'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :doctors, :skip => [:registrations], controllers: { sessions: "doctors/sessions" }
  devise_scope :doctors do
    get "/doctors", to: "doctors#index"
    get "/profile/doctor", to: "doctors#profile"
    post "/edit_password/doctor/:id", to: "doctors#edit_password"
    post "/edit_photo/doctor/:id", to: "doctors#edit_photo"
    post "/update/doctor/:id", to: "doctors#update"
  end
  devise_for :patients, controllers: { registrations: "patients/registrations", sessions: "patients/sessions" }
  devise_scope :patients do
    get "/profile/patient", to: "patients#profile"
    post "/update/patient/:id", to: "patients#update"
  end
  resources :appointments
  put "/update/appointments", to: "appointments#add_recommendation"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
