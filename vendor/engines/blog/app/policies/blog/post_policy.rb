module Blog
  class PostPolicy < Auth::ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        # TODO: ne a blog show mutassa a cikkeket hanem a posts index
        if user && user.has_role?(:system)
          scope.order('created_at desc')
        else
          scope.where(published: true).order('created_at desc')
        end
      end

      def by_year_and_month(year, month)
        resolve.where("extract(year from created_at) = ? AND extract(month from created_at) = ? ", year, month).order("created_at DESC")
      end

      def by_tag(tag)
        resolve.tagged_with(tag)
      end

      private

      attr_reader :user, :scope
    end

    def index?
      true
    end

    def show?
      true
    end

    def new?
      !@user.nil? && @user.has_role?(:system)
    end

    def create?
      new?
    end

    def edit?
      !@user.nil? && @user.has_role?(:system)
    end

    def update?
      edit?
    end

    def destroy?
      edit?
    end

    def by_year_and_month?
      index?
    end

    def by_tag?
      index?
    end

    def permitted_attributes
      #if user.admin? || user.owner_of?(post)
      #  [:title, :body, :tag_list]
      #else
      #  [:tag_list]
      #end
      [:title, :content, :my_tags, :published]
    end
  end
end