class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  SPECIALITIES = ["dentist", "general practicioner", "allergist", "cardiologist", "dermatologist", "gastroenterologist", "hematologist", "internist", "neurologist", "oncologist", "ophthalmologist", "osteopath", "otolaryngologist", "pediatrician", "plastic surgeon", "podiatrist", "psychiatrist", "pulmonologist", "rheumatologist", "surgeon", "urologist", "other"]

  def home
    @SPECIALITIES = SPECIALITIES.sort
  end
end
