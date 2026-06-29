class Blog::UsersController < Blog::BaseController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    users = User.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: {
      users: users.map { |user| user.as_json },
      meta: {
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_entries: users.total_entries
      }
    }
  end

  def show
    render json: @user.as_json
  end

  def edit
  end

  def update
    if @user.update(user_params)
      render json: { id: @user.id}
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { message: 'User deleted.' }
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.expect(user: [ :first_name, :last_name, :email_address ])
    end
end
