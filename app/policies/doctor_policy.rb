class DoctorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def permitted_attributes
    [:email, :password, :first_name, :last_name, :speciality, :address, :photo, :phone_number, :opening_hour, :closing_hour]
  end
end
