class Doctors::AppointmentsController < ApplicationController
  alias pundit_user current_doctor
  skip_before_action :authenticate_user!, only: [:index, :update]
  before_action :authenticate_doctor!
  def index
    @appointments = policy_scope(Appointment, policy_scope_class: AppointmentPolicy::DoctorScope).order(:date)
  end

  def update
    @appointment = Appointment.find(params[:id])
    authorize @appointment
    @appointment.update(appointment_params)
    redirect_to doctors_appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:user_id, :doctor_id, :date, :is_confirmed)
  end
end
