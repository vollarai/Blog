class Settings::UsersController < Settings::BaseController
  def show
  end

  def destroy
    Current.user.destroy
    render json: { message: "Your account has been deleted." }
  end
end
