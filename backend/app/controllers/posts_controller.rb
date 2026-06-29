class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  def index
    posts = Post.includes(:image).order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    render json: {
      posts: posts.map { |post|
        post.as_json.merge(image_url: post.image&.image&.url)
      },
      meta: {
        current_page: posts.current_page,
        total_pages: posts.total_pages,
        total_entries: posts.total_entries
      }
    }
  end

  def pdf
    post = Post.find(params[:id])
    pdf = post.pdfs.processed.last
    if pdf&.file&.attached?
      send_data pdf.file.download, filename: "#{pdf.filename}.pdf", type: "application/pdf"
    else
      render json: { error: 'No PDF available' }, status: :not_found
    end
  end


  def show
    post = Post.includes(:image).find(params[:id])
    render json: post.as_json.merge(image_url: post.image&.image&.url)
  end
end
