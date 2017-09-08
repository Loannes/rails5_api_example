class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :token
  has_many :posts
  link(:self) { api_v1_user_url(object) }
end