class Settings::EmailsController < Settings::BaseController
  def show
  end

  def update
    if Current.user.update(email_params)
      UserMailer.with(user: Current.user).email_confirmation.deliver_later
      render json: { message: "We've sent a verification email to #{Current.user.unconfirmed_email}." }
    else
      Rails.logger.error "Email update failed: #{Current.user.errors.full_messages}"
      render json: { errors: Current.user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def email_params
      params.expect(user: [ :password_challenge, :unconfirmed_email ]).with_defaults(password_challenge: "")
    end
end
