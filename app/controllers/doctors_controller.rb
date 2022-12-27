class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[update_password update_photo update show]
  load_and_authorize_resource
  skip_authorization_check :index

  def index
    @doctors = DoctorsListQuery.new(params[:search_category], params[:search_surname], params[:page]).show
  end

  def update_password
    DoctorsService.new(@doctor, params[:password], params[:password_confirmation], nil, nil, nil, nil,
                       nil).update_password
  end

  def update_photo
    DoctorsService.new(@doctor, nil, nil, params[:avatar], nil, nil, nil, nil).update_photo
  end

  def update
    DoctorsService.new(@doctor, nil, nil, nil, params[:category_id], params[:phone], params[:name], 
                       params[:surname]).update
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
