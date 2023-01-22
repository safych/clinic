class DoctorsListQuery
  def initialize(search_category, search_surname, page)
    @search_category = search_category
    @search_surname = search_surname
    @page = page
  end

  def sort
    return sort_by_category if @search_category.present?
    return sort_by_surname if @search_surname.present?

    Doctor.where.not(category_id: nil).order('surname ASC').page @page
  end

  def sort_by_category
    Doctor.where(category_id: @search_category).where.not(category_id: nil)
          .order('surname ASC').page @page
  end

  def sort_by_surname
    Doctor.where(surname: @search_surname).where.not(category_id: nil)
          .order('name ASC').page @page
  end
end
