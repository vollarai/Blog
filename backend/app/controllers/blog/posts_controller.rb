class Blog::PostsController < Blog::BaseController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    posts = Post.includes(:image).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: {
      posts: posts.map { |post| post.as_json.merge(image_url: post.image&.image&.url) },
      meta: {
        current_page: posts.current_page,
        total_pages: posts.total_pages,
        total_entries: posts.total_entries
      }
    }
  end

  def show
    render json: @post.as_json.merge(image_url: @post.image&.image&.url)
  end

  def new
    @post = Post.new
    @post.build_image
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: { id: @post.id }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @post.build_image if @post.image.nil?
  end

  def update
    if @post.update(post_params)
      render json: { id: @post.id }
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json: { message: 'Post deleted.' }
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.expect(post: [ :name, :title, :content, image_attributes: [ :image ] ])
    end
end
