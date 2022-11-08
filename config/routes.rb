Rails.application.routes.draw do
  devise_for :doctors
  devise_for :patients, controllers: { registrations: 'patients/registrations' }
  root to: 'welcome#index'
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
