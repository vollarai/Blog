class PdfDownloadingJob < ApplicationJob
  queue_as :default

  def perform(pdf_id)
    pdf = Pdf.find(pdf_id)
    post = pdf.post

    begin
      pdf.update!(status: "processing")

      html = ActionController::Base.render( template: "posts/pdf", layout: "pdf", assigns: { post: post })
      pdf_content = WickedPdf.new.pdf_from_string(html, background: true, page_size: "A4", margin: { top: "0", right: "0", bottom: "0", left: "0" }, extra: "--enable-local-file-access")
      pdf.file.attach( io: StringIO.new(pdf_content), filename: "#{post.title.parameterize}-#{pdf.id}.pdf", content_type: "application/pdf")

      pdf.update!(status: "processed")
    rescue => e
      pdf&.update!(status: "failed")
      raise e
    end
  end
end
