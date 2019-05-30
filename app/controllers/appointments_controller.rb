class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
    @appointments = policy_scope(Appointment).order(:date)
  end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    @appointments = Appointment.where(doctor: @doctor)
    @appointment = Appointment.new
    authorize @appointment
    @time = params[:format]
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    @appointment = Appointment.new(user_id: current_user.id, doctor_id: params[:doctor_id], date: params[:time])
    authorize @appointment
    @appointment.doctor = @doctor
    @appointment.user = current_user
    if @appointment.save
      redirect_to appointments_path
    else
      @appointments = Appointment.where(doctor: @doctor)
      render :new
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_params)
    redirect_to appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:user_id, :doctor_id, :date, :is_confirmed)
  end
end
