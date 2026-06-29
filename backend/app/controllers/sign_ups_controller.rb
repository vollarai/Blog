class SignUpsController < ApplicationController
  unauthenticated_access_only
  rate_limit to: 10, within: 3.minutes, only: :create, 
    with: -> { render json: { error: "Try again later." }, status: too_many_requests}
  def show
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      render json: { token: generate_token(@user), user: { id: @user.id, email: @user.email_address, name: @user.full_name, admin: @user.roles.include?(:admin) } }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def sign_up_params
      params.expect(user: [ :first_name, :last_name, :email_address, :password, :password_confirmation ])
    end
end
