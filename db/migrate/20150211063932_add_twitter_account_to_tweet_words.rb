class AddTwitterAccountToTweetWords < ActiveRecord::Migration
  def change
    add_reference :tweet_words, :twitter_account, index: true
  end
end
