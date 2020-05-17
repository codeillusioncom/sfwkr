module Webshop
  class WebshopPolicy < Auth::ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user && user.has_role?(:system)
          scope.order(:name)
        else
          scope.none
        end
      end

      def resolve_products(webshop)
        ::Webshop::Product.where(webshop_id: webshop.id).order(:name)
      end

      private

      attr_reader :user, :scope
    end

    def index?
      !user.nil?
    end

    def show?
      !@record.blank?
    end

    def new?
      !@user.nil?
    end

    def create?
      !@user.nil? && @user.has_role?(:system)
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

    def permitted_attributes
      #if user.admin? || user.owner_of?(post)
      #  [:title, :body, :tag_list]
      #else
      #  [:tag_list]
      #end
      [:title, :content, :published, fragments_attributes: [:id, :fragment_name, :order, :_destroy]]
    end
  end
end