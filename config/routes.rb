Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :doctors, :skip => [:registrations]
  devise_scope :patients do
    get "/doctors", to: "doctors#index"
  end
  devise_for :patients, controllers: { registrations: "patients/registrations", sessions: "patients/sessions" }
  devise_scope :patients do
    get "/profile/patient", to: "patients#profile"
    put "/patients/:id", to: "patients#update"
  end
  # devise_scope :appointments do
    # get "/appointments", to: "appointments#index"
    # get "/appointments/new", to: "appointments#new"
    # get "/appointments/:id", to: "appointments#show"
    # post "/appointments", to: "appointments#create"
  # end
  resources :appointments
  root to: "welcome#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end