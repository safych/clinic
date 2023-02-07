class ProfilePasswordUpdater < ApplicationService
  def initialize(user, password, password_confirmation)
    @user = user
    @password = password
    @password_confirmation = password_confirmation
  end

  def call
    update_password
  end

  private

  def update_password
    return error_length_password if @password.to_s.length < 5
    return error_pwd_confirmation if @password != @password_confirmation
    return successful_update if check_update

    ServiceStatus.new(false, I18n.t('services.password_updater.not_successful_update'))
  end

  def check_update
    password = BCrypt::Password.create(@password)
    @user.update(encrypted_password: password)
  end

  def successful_update
    ServiceStatus.new(true, I18n.t('services.password_updater.successful_update'))
  end

  def error_length_password
    ServiceStatus.new(false, I18n.t('services.password_updater.error_length_password'))
  end

  def error_pwd_confirmation
    ServiceStatus.new(false, I18n.t('services.password_updater.error_pwd_confirmation'))
  end
end
