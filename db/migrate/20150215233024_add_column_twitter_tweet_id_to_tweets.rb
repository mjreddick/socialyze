class AddColumnTwitterTweetIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :twitter_tweet_id, :string
  end
end
