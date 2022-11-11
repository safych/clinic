Rails.application.routes.draw do
  devise_for :doctors, :skip => [:registrations]
  devise_for :patients, controllers: { registrations: "patients/registrations", sessions: "patients/sessions" }
  devise_scope :patients do
    get "/profile/patient", to: "patients#profile"
    put "/patients/:id", to: "patients#update"
  end
  root to: "welcome#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
