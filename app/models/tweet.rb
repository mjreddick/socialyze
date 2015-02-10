class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :tweet_text, presence: true
  validates :user_id, presence: true
end
