class Tweet < ActiveRecord::Base
  belongs_to :twitter_account

  validates :tweet_text, presence: true
  validates :twitter_account_id, presence: true
end
