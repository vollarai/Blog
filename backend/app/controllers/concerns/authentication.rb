module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end

    def unauthenticated_access_only(**options)
      allow_unauthenticated_access(**options)
      before_action -> { render json: { error: "Already authenticated" }, status: :forbidden if current_user }, **options
    end
  end

  private

  def current_user
    @current_user ||= begin
      token = extract_token
      if token
        payload = JsonWebToken.decode(token)
        if payload
          user = User.find(payload[:user_id])
          Current.user = user
          user
        end
      end
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def authenticated?
    current_user.present?
  end

  def require_authentication
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
  end

  def extract_token
    header = request.headers["Authorization"]
    header.split(" ").last if header&.start_with?("Bearer ")
  end

  def generate_token(user)
    JsonWebToken.encode(user_id: user.id)
  end
end