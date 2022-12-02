class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit destroy ]
  load_and_authorize_resource

  def index
    if current_user.class.name == "Patient"
      search_patient
    elsif current_user.class.name == "Doctor"
      search_doctor
    end
  end

  def search_patient
    if params[:search_status].present?
      @appointments = Appointment.where(patient_id: current_user.id, status: params[:search_status]).order('id DESC')
    elsif params["search_date(1i)"].present?
      date = Date.new(params["search_date(1i)"].to_i, params["search_date(2i)"].to_i, params["search_date(3i)"].to_i)
      @appointments = Appointment.where(patient_id: current_user.id, date: date.to_fs(:iso8601))
    else
      @appointments = Appointment.where(patient_id: current_user.id).limit(50).order('id DESC')
    end
  end

  def search_doctor
    if params[:search_status].present?
      @appointments = Appointment.where(doctor_id: current_user.id, status: params[:search_status]).order('id DESC')
    elsif params[:search_date].present?
      date = Date.new(params["search_date(1i)"].to_i, params["search_date(2i)"].to_i, params["search_date(3i)"].to_i)
      @appointments = Appointment.where(doctor_id: current_user.id, date: date.to_fs(:iso8601))
    else
      @appointments = Appointment.where(doctor_id: current_user.id).order('id DESC')
    end
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def edit
  end

  def create
    @appointment = Appointment.new(appointment_params)
    verification = Appointment.find_by(patient_id: params[:appointment][:patient_id], date: @appointment.date, doctor_id: params[:appointment][:doctor_id])
    respond_to do |format|
      if count_appointment.length < 11 && verification.nil?
        @appointment.save
        format.html { redirect_to appointments_path, notice: "Appointment was successfully created." }
        format.json { render :index, status: :created }
      else
        format.html { 
          redirect_to appointments_path,
          status: :unprocessable_entity,
          notice: "Appointment wasn't successfully created. Because the doctor has no more places for today or you have already booked an appointment." 
        }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def count_appointment
    appointments_doctor = Appointment.find_by(doctor_id: params[:appointment][:doctor_id], date: params[:appointment][:date], status: "wait")
    appointments_doctor if !appointments_doctor.nil?
    [] if appointments_doctor.nil?
  end


  def add_recommendation
    @appointment = Appointment.find_by(id: params[:id])
    respond_to do |format|
      if @appointment.update(recommendation: params[:recommendation], status: "done")
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully added to the recommendation." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity, locals: { appointment: @appointment } }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:doctor_id, :patient_id, :status, :recommendation, :date)
    end

    def date_params
      params.require(:appointment).permit(:date)
    end
end
