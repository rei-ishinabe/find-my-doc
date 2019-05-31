class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:specialities] || params[:address]
      sql_query = "speciality ILIKE ::specialities OR syllabus ILIKE :query"
      @doctors = policy_scope(Doctor.where(speciality: params[:specialities]))
    else
      @doctors = policy_scope(Doctor)
    end
      @markers = @doctors.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude
        }
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
    @review = Review.find(@doctor.id)
    authorize @doctor
    @markers = [{
          lat: @doctor.latitude,
          lng: @doctor.longitude
        }]
  end
end
