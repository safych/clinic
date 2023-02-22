Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'welcome#index'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :doctors, skip: [:registrations], controllers: { sessions: 'doctors/sessions' }
  get '/doctors', to: 'doctors#index'

  devise_for :patients, controllers: { registrations: 'patients/registrations', sessions: 'patients/sessions' }

  resources :appointments

  resource :profile, only: %i[show update], controller: 'profile' do
    post :update_password
    post :update_photo
  end
end
