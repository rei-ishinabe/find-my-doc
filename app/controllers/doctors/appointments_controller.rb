class Doctors::AppointmentsController < ApplicationController
  alias pundit_user current_doctor
  skip_before_action :authenticate_user!, only: [:index]
  before_action :authenticate_doctor!
  def index
    @appointments = policy_scope(Appointment, policy_scope_class: AppointmentPolicy::DoctorScope).order(:date)
  end
end
