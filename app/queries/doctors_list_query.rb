class DoctorsListQuery
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def list
    doctors = Doctor.order('surname ASC').page params[:page]
    doctors = doctors.where(category_id: params[:category]).page params[:page] if params[:category].present?
    doctors = doctors.where(surname: params[:surname]).page params[:page] if params[:surname].present?
    doctors
  end
end
