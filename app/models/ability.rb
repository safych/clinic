# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Doctor, public: true

    if user.instance_of?(::AdminUser)
      can :manage, :all
    elsif user.instance_of?(::Doctor)
      can :manage, Appointment, doctor: user
      cannot :create, Appointment
      can :manage, Doctor, id: user.id
    elsif user.instance_of?(::Patient)
      can :manage, Appointment, patient: user
      cannot :update, Appointment
      can :manage, Patient, id: user.id
    end
  end
end
