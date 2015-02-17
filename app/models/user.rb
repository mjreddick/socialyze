class User < ActiveRecord::Base
  has_one :twitter_account
  has_one :api_key, dependent: :destroy
  has_secure_password
  before_create :create_api_key

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  validates :name, presence: true

  before_save do
    self.email = email.downcase
    # capitalizes each word submitted for name if more than one word
    self.name = name.titleize
  end

  def self.find_by_access_token(access_token)
    APIKey.find_by(access_token: access_token).user
  end

  private 

  def create_api_key
    self.api_key = APIKey.create 
  end

end
