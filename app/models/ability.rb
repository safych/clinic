# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Doctor, public: true

    if user.class.name == "AdminUser"
      can :manage, :all
    elsif user.class.name == "Doctor"
      can :manage, Appointment
      cannot :create, Appointment
      can :manage, Doctor
    elsif user.class.name == "Patient"
      can :manage, Appointment
      cannot :update, Appointment
      can :manage, Patient
    end
  end
end
