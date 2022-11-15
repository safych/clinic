Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :doctors, :skip => [:registrations], controllers: { sessions: "doctors/sessions" }
  devise_scope :doctors do
    get "/doctors", to: "doctors#index"
    get "/profile/doctor", to: "doctors#profile"
  end
  devise_for :patients, controllers: { registrations: "patients/registrations", sessions: "patients/sessions" }
  devise_scope :patients do
    get "/profile/patient", to: "patients#profile"
    put "/patients/:id", to: "patients#update"
  end
  resources :appointments
  put "/update/appointments", to: "appointments#add_recommendation"
  root to: "welcome#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
