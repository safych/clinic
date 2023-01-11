module Admin
  class SessionsController < ActiveAdmin::Devise::SessionsController
    skip_authorization_check
  end
end
