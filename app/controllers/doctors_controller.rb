class DoctorsController < ApplicationController
  def index
    @doctors = DoctorsListQuery.new(list_params).list
  end

  private

  def list_params
    params.permit(:search_category, :search_surname, :page)
  end
end
