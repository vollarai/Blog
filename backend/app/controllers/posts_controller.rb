class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 3)
  end

  def show
    @post = Post.find(params[:id])
  end

  # def pdf
  #   @post = Post.find(params[:id])
  #   html = render_to_string(template: "posts/pdf", layout: "pdf")
  #   pdf_content = WickedPdf.new.pdf_from_string(html, background: true, page_size: "A4", margin: { top: "0", right: "0", bottom: "0", left: "0" }, extra: "--enable-local-file-access")
  #   send_data pdf_content, filename: "#{@post.title.parameterize}.pdf", type: "application/pdf"
  # end
end
