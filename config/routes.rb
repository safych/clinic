Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'welcome#index'
  end

  ActiveAdmin::Devise.config[:controllers][:sessions] = 'admin/sessions'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :doctors, skip: [:registrations], controllers: { sessions: 'doctors/sessions' }
  devise_scope :doctors do
    get '/doctors', to: 'doctors#index'
  end

  devise_for :patients, controllers: { registrations: 'patients/registrations', sessions: 'patients/sessions' }

  resources :appointments

  resource :profile, only: :show, controller: 'profile'

  devise_scope :profile do
    post '/update', to: 'profile#update'
    post '/update_password', to: 'profile#update_password'
    post '/update_photo', to: 'profile#update_photo'
  end
end
