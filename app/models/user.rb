class User < ApplicationRecord
  before_create -> {self.token = generate_token}
  validates :name, presence: true

  has_many :posts, :dependent => :destroy





  private

  def generate_token
    loop do
      token = SecureRandom.hex
      return token unless User.exists?({token: token})
    end
  end
end
