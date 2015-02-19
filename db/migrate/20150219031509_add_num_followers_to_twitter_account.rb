class AddNumFollowersToTwitterAccount < ActiveRecord::Migration
  def change
    add_column :twitter_accounts, :num_followers, :integer
    add_column :twitter_accounts, :total_num_tweets, :integer
  end
end
