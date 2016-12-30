class WikiPolicy < ApplicationPolicy

    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def index?
      true
    end
  
    def show?
      user.present? || user.admin?
    end
  
    def create?
      user.present? || user.admin?
    end
  
    def new?
      user.present? || user.admin?
    end
  
    def update?
      user.present? || user.admin?
    end
  
    def edit?
      user.present? || user.admin?
    end
  
    def destroy?
      user.admin?
    end

    
    # def resolve
    #   if user.admin?
    #     scope.all
    #   elsif user.premium?
    #     scope.where(private: true, user_id: user.id) || scope.where(private: false)
    #   else
    #     scope.where(private: false)
    #   end
    # end
end

