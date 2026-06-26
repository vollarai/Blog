class Settings::PasswordsController < Settings::BaseController
  def show
  end

  def update
    if Current.user.update(password_params)
      render json: { message: "Your password has been updated." }
    else
      Rails.logger.error "Password update failed: #{Current.user.errors.full_messages}"
      render json: { errors: Current.user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def password_params
      params.expect(user: [ :password, :password_confirmation, :password_challenge ]).with_defaults(password_challenge: "")
    end
end
