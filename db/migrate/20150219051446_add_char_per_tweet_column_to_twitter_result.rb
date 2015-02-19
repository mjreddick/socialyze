class AddCharPerTweetColumnToTwitterResult < ActiveRecord::Migration
  def change
    add_column :twitter_results, :char_per_tweet, :text
  end
end
