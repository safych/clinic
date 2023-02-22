class DoctorsController < ApplicationController
  def index
    @doctors = DoctorsListQuery.new(index_params).list
  end

  private

  def index_params
    params.permit(:category, :surname, :page)
  end
end
