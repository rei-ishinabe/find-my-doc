class Doctors::AppointmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :authenticate_doctor!
  def index
    @appointments = policy_scope(Appointment)
  end
end
