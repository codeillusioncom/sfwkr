module Pages
  class MenuItemPolicy < Auth::ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user
          (scope.where(user_id: user.id).or(scope.where(user_id: nil))).order(:title)
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
      false
    end

    def new?
      !@user.nil?
    end

    def create?
      !@user.nil? && @user.has_role?(:system)
    end

    def edit?
      !@user.nil? && @user.has_role?(:system) && ['Pages::Page', 'Pages::Url', 'Blog::Blog', 'Webshop::Webshop'].include?(@record.menuable_type)
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
      [:title, :menu_id, :user_id, :menuable_type, :menuable_id]
    end
  end
end