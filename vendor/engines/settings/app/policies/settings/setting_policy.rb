module Settings
  class SettingPolicy < Auth::ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user
          puts "---"
          puts user.inspect
          scope.where(user_id: user.id).order(:key)
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
      @record.published || @record.user_id == user.id
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
      [:key, :value]
    end
  end
end