class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
  has_many :reviews, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
