class Doctor < ApplicationRecord
  has_many :appointments

  SPECIALITIES = ["dentist", "general practicioner", "allergist", "cardilogist", "dermatologist", "gastroenterologist", "hematologist", "internist", "neurologist", "oncologist", "ophthalmologist", "osteopath", "otolaryngologist", "pediatrician", "plastic surgeon", "podiatrist", "psychiatrist", "pulmonologist", "rheumatologist", "surgeon", "urologist", "other"]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :speciality, presence: true, inclusion: { in: SPECIALITIES }
  validates :address, presence: true
  validates :gender, presence: true, inclusion: { in: ["male", "female"] }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
