class RemoveReferencesFromTweetWords < ActiveRecord::Migration
  def change
    remove_reference :tweet_words, :user, index: true
    remove_reference :tweet_words, :tweet, index: true
  end
end
