class Pdf < ApplicationRecord
  belongs_to :post
  has_one_attached :file

  enum :status,{
    pending: "pending",
    processing: "processing",
    processed: "processed",
    failed: "failed"
  }
end