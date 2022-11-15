class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    verification = Appointment.find_by(patient_id: params[:appointment][:patient_id], date: @appointment.date, doctor_id: params[:appointment][:doctor_id])
    respond_to do |format|
      if count_appointment.length < 11 && verification.nil?
        @appointment.save
        format.html { redirect_to appointments_path, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity, notice: "Appointment wasn't successfully created." }
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
    @appointment = Appointment.find(params[:id])
    respond_to do |format|
      if @appointment.update(recommendation: params[:recommendation], status: "done") && params[:recommendation] != ""
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully added to the recommendation." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity, notice: "Appointment wasn't successfully updated. Because recommendation empty." }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:doctor_id, :patient_id, :status, :recommendation, :date)
    end
end
