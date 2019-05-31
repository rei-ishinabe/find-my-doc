class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:specialities] || params[:address]
      sql_query = "speciality ILIKE ::specialities OR syllabus ILIKE :query"
      @doctors = policy_scope(Doctor.where(speciality: params[:specialities])).sort_by { |doctor| -doctor.average_rating }
    else
      @doctors = policy_scope(Doctor).sort_by { |doctor| -doctor.average_rating }
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
    authorize @doctor
    @markers = [{
          lat: @doctor.latitude,
          lng: @doctor.longitude
        }]
  end
end
