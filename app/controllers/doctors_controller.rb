class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @doctors = policy_scope(Doctor)
  end

  def show
    @doctor = Doctor.find(params[:id])
    authorize @doctor
  end
end
