class AddColumnsToTwitterResult < ActiveRecord::Migration
  def change
    add_reference :twitter_results, :user_id, index: true
    add_column :twitter_results, :most_used_words, :text
    add_column :twitter_results, :least_used_words, :text
    add_column :twitter_results, :early_bird, :boolean
    add_column :twitter_results, :avg_tweet_length, :decimal
    add_column :twitter_results, :num_followers, :integer
    add_column :twitter_results, :total_tweets, :integer
    add_column :twitter_results, :followers_most_used_words, :text
    add_column :twitter_results, :followers_least_used_words, :text
    add_column :twitter_results, :followers_early_bird, :boolean
    add_column :twitter_results, :followers_avg_tweet_length, :decimal
    add_column :twitter_results, :followers_avg_num_followers, :decimal
    add_column :twitter_results, :followers_avg_total_tweets, :decimal
  end
end
