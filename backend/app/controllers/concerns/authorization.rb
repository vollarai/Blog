module Authorization
  extend ActiveSupport::Concern

  class_methods do
    def admin_access_only(**options)
      before_action(-> {
        render json: { error: "Forbidden" }, status: :forbidden unless current_user&.roles?(:admin)
      }, **options)
    end
  end
end