module Pages
  class MenuPolicy < Auth::ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user
          scope.order(:menu_type)
        else
          scope.none
        end
      end

      private

      attr_reader :user, :scope
    end

    def index?
      !user.nil?
    end

    def show?
      !@user.nil?
    end

    def new?
      !@user.nil?
    end

    def create?
      !@user.nil? && @record.user_id == user.id
    end

    def edit?
      !@user.nil? && @record.user_id == user.id
    end

    def update?
      edit?
    end

    def destroy?
      edit?
    end

    def permitted_attributes
      #if user.admin? || user.owner_of?(post)
      #  [:title, :body, :tag_list]
      #else
      #  [:tag_list]
      #end
      [:title, :content, :published]
    end
  end
end