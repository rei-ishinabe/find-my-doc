class ReviewsController < ApplicationController
  def index
    @reviews = Review.find(params[:doctor_id])
  end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    @review = Review.new
    authorize @review
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    @review = Review.new(stars:review_params[:stars], content:review_params[:content], user_id: current_user.id, doctor_id: params[:doctor_id])
    authorize @review
    @review.doctor = @doctor
    @review.user = current_user
    if @review.save

      redirect_to doctor_path(@doctor)
    else
      @reviews = Review.where(doctor: @doctor)
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:user_id, :doctor_id, :stars, :content)
  end
end
