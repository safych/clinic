class DoctorsListQuery < ApplicationQuery
  def initialize(search_category, search_surname, page)
    @search_category = search_category
    @search_surname = search_surname
    @page = page
  end

  def call
    show
  end

  private

  def show
    if @search_category.present?
      @doctors = Doctor.where(category_id: @search_category).where.not(category_id: nil)
                       .order('surname ASC').page @page
    elsif @search_surname.present?
      @doctors = Doctor.where(surname: @search_category).where.not(category_id: nil)
                       .order('name ASC').page @page
    else
      @doctors = Doctor.where.not(category_id: nil).order('surname ASC').page @page
    end
  end
end