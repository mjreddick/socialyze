class User < ActiveRecord::Base
  has_one :twitter_account
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  validates :name, presence: true

  before_save do
    self.email = email.downcase
    # capitalizes each word submitted for name if more than one word
    self.name = name.titleize
  end

end
