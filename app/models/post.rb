class Post < ApplicationRecord
  validates :name, presence: true
  validates :title, presence: true

  has_many :comments, dependent: :destroy
  has_one :image, dependent: :destroy
  accepts_nested_attributes_for :image
end
