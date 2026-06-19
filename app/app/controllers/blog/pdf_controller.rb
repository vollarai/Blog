class Blog::PdfController < Blog::BaseController
  def show
    pdf = Pdf.find(params[:id])
    send_data pdf.file.download, filename: "#{pdf.filename}.pdf", type: "application/pdf"
  end

  def index
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @pdfs = @post.pdfs
    else
      @pdfs = Pdf.all.includes(:post)
    end
  end

  def create
    @post = Post.find(params[:post_id])

    post_pdf = @post.pdfs.create!(filename: nil, status: "pending")
    post_pdf.update!(filename: "#{@post.title.parameterize}-#{post_pdf.id}")

    PdfDownloadingJob.perform_later(post_pdf.id)

    redirect_to post_path(@post)
  end

end