class AddColumnTwitterTweetIdToTweets < ActiveRecord::Migration
  def change
    add_reference ::tweets, :twitter_tweet_id, :string
  end
end
