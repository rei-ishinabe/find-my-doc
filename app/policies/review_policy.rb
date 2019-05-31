class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(review: review)
    end
  end

  class DoctorScope < Scope
    def resolve
      scope.where(doctor: review)
    end
  end
    def index
      true
    end

    def create?
      true
    end

    def new?
      true
    end
end
