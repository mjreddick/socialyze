class User < ActiveRecord::Base
  
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  before_save do
    self.email = email.downcase
  end

end
