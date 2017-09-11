class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  mount_base64_uploader :picture, PictureUploader
end
