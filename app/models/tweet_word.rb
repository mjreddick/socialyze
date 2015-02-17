class TweetWord < ActiveRecord::Base
  belongs_to :twitter_account

  validates :word, presence: true
  validates :twitter_account_id, presence: true
end
