module Webshop
  class OrderPolicy < Auth::ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user && user.has_role?(:system)
          scope.order('created_at desc')
        else
          # scope.none
        end
      end

      private

      attr_reader :user, :scope
    end

    def index?
      @user && @user.has_role?(:system)
    end

    #def show?
    #  @user && @user.has_role?(:system)
    #end

    def new?
      @user
    end

    def create?
      @user
    end

    def permitted_attributes
      # TODO: csak a cím legyen itt
      [:name, :email, :address]
    end
  end
end