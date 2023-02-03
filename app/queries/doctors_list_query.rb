class DoctorsListQuery
  def initialize(list_params)
    @list_params = list_params
  end

  def list
    return sort_by_category if @list_params[:search_category].present?
    return sort_by_surname if @list_params[:search_surname].present?

    Doctor.where.not(category_id: nil).order('surname ASC').page @list_params[:page]
  end

  def sort_by_category
    Doctor.where(category_id: @list_params[:search_category]).where.not(category_id: nil)
          .order('surname ASC').page @list_params[:page]
  end

  def sort_by_surname
    Doctor.where(surname: @list_params[:search_surname]).where.not(category_id: nil)
          .order('name ASC').page @list_params[:page]
  end
end
