class Blog::PostsController < Blog::BaseController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @post = Post.new
    @post.build_image
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to blog_post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post.build_image if @post.image.nil?
  end

  def update
    if @post.update(post_params)
      redirect_to blog_post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to blog_posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.expect(post: [ :name, :title, :content, image_attributes: [ :image ] ])
    end
end
