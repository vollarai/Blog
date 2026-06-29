class Settings::ProfilesController < Settings::BaseController
  def show
  end

  def update
    if Current.user.update(profile_params)
      render json: { user: Current.user }, status: :ok
    else
      render json: { errors: Current.user.errors.full_messages }, status: :unprocessable_entity
      render json: { errors: Current}
    end
  end

  private
    def profile_params
      params.expect(user: [ :first_name, :last_name ])
    end
end
