class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :reviews, dependent: :destroy


  SPECIALITIES = ["dentist", "general practicioner", "allergist", "cardiologist", "dermatologist", "gastroenterologist", "hematologist", "internist", "neurologist", "oncologist", "ophthalmologist", "osteopath", "otolaryngologist", "pediatrician", "plastic surgeon", "podiatrist", "psychiatrist", "pulmonologist", "rheumatologist", "surgeon", "urologist", "other"]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :speciality, presence: true, inclusion: { in: SPECIALITIES }
  validates :address, presence: true
  validates :gender, presence: true, inclusion: { in: ["male", "female"] }
  validates :email, presence: true, uniqueness: true

  mount_uploader :photo, PhotoUploader
  # for map
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def float_to_hour(float)
    min = (float * 60).to_i
    hour, min = min.divmod(60)
    "%02d:%02d" % [hour, min] # => "13:30:00"
  end

  def opening_hours
    "#{float_to_hour(opening_hour)} - #{float_to_hour(closing_hour)}"
  end

  def self.specialities_list
    SPECIALITIES
  end

  def average_rating
    return 0 if reviews.empty?

    sum = 0.0

    reviews.each do |review|
      sum += review[:stars]
    end

    sum / reviews.count
  end
end
