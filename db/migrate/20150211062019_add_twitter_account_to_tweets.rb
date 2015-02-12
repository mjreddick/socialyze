class AddTwitterAccountToTweets < ActiveRecord::Migration
  def change
    add_reference :tweets, :twitter_account, index: true
  end
end
