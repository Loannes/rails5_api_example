class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :picture
  belongs_to :user
  link(:self) { api_v1_post_url(object) }
end