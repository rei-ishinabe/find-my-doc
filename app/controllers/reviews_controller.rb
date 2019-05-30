class ReviewsController < ApplicationController
  def new
    @doctor = Character.find(params[:doctor_id])
    @review = Review.new
  end
end
