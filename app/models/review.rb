class Review < ApplicationRecord
  belongs_to :doctor
  belongs_to :user

  validates :stars, presence: true, inclusion: {in: 1..5}
  validates :content, presence: true
  validates :doctor_id, uniqueness: { scope: :user_id, message: "You've already reviewed this doctor!" }
end
