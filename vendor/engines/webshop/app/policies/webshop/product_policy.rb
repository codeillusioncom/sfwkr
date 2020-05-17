module Webshop
  class ProductPolicy < Auth::ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user && user.has_role?(:system)
          scope.order(:title)
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
      true
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
      [
          :name, :description, :net_price, :tax, :sku, :barcode, :track_quantity, :continue_selling_when_out_of_stock,
          :available_pieces, :physical_product, :unit_name, :unit_value, :country_of_origin, :vendor, :tags, :groups, :notes,
          images: []
      ]
    end
  end
end