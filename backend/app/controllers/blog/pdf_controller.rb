class Blog::PdfController < Blog::BaseController
  def show
    pdf = Pdf.find(params[:id])
    send_data pdf.file.download, filename: "#{pdf.filename}.pdf", type: "application/pdf"
  end

  def index
    # pdfs = Pdf.all.includes(:post)
    pdfs = Pdf.order(created_at: :desc)
    render json: {
      pdfs: pdfs.map { |pdf| {
        id: pdf.id,
        filename: pdf.file.attached? ? pdf.file.filename.to_s : "#{pdf.filename}.pdf",
        status: pdf.status,
        post_title: pdf.post.title,
        downloadable: pdf.processed? && pdf.file.attached?
      }}
    }
  end

  def create
    @post = Post.find(params[:post_id])

    post_pdf = @post.pdfs.create!(filename: nil, status: "pending")
    post_pdf.update!(filename: "#{@post.title.parameterize}-#{post_pdf.id}")

    PdfDownloadingJob.perform_later(post_pdf.id)

    render json: { message: 'PDF generation started.' }
  end

end