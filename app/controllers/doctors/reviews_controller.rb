class Doctors::ReviewsController < ApplicationController
  alias pundit_user current_user
  skip_before_action :authenticate_user!, only: [:index, :update]
  before_action :authenticate_doctor!
  def index
    @reviews = policy_scope(Review, policy_scope_class: ReviewPolicy::DoctorScope).order(:date)
  end

  def update
    @review = Review.find(params[:id])
    authorize @review
    @review.update(review_params)
    redirect_to doctors_reviews_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:user_id, :doctor_id, :date, :is_confirmed)
  end
end
