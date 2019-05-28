class AppointmentsController < ApplicationController
  def index
    # @appointments = Appointment.all
    @appointments = policy_scope(Appointment)
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appoinement.save
      redirect_to appointments_path
    else
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
    params.require(:appoinement).permit(:date, :is_confirmed)
  end
end
