module Admin
  class SessionsController < ActiveAdmin::Devise::SessionsController
    skip_authorization_check
    load_and_authorize_resource, only: :destroy
  end
end