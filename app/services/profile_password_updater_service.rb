require 'bcrypt'

class ProfilePasswordUpdaterService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def update_password
    @service_status_error = ServiceStatus.new(false, [])
    error_length_password if @params[:password].to_s.length < 5
    error_pwd_confirmation if @params[:password] != @params[:password_confirmation]
    return successful_update if check_update && @service_status_error.notice.empty?

    @service_status_error.notice.push(I18n.t('services.password_updater.not_successful_update'))
    @service_status_error
  end

  def check_update
    password = BCrypt::Password.create(@params[:password])
    @user.update(encrypted_password: password)
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.password_updater.successful_update'))
  end

  def error_length_password
    @service_status_error.notice.push(I18n.t('services.password_updater.error_length_password'))
  end

  def error_pwd_confirmation
    @service_status_error.notice.push(I18n.t('services.password_updater.error_pwd_confirmation'))
  end
end
