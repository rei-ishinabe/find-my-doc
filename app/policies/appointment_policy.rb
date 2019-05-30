class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  class DoctorScope < Scope
    def resolve
      scope.where(doctor: user)
    end
  end


    def create?
      true
    end

    def new?
      true
    end
end
