class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def profile
  end
end