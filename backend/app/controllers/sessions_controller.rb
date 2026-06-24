class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, 
    with: -> { render json: { error: "Try again later." }, status: too_many_requests }
  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
     render json: { token: generate_token(user), user: { id: user.id, email: user.email_address, name: user.full_name } }
    else
      render json: { error: "Invalid email or password."}, status: unauthorized
    end
  end

  def destroy
    render json: { message: "Logged out."}
  end
end
