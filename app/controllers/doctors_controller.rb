class DoctorsController < ApplicationController
  def index
    @doctor = Doctor.all
  end
end