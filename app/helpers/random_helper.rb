module RandomHelper

  # REMEMBER TO ADD CHARACTER COUNT (TWEET LENGTH TO TABLE)
  # tweet.character_count = tweet.tweet_text.length (add twice!)
  def avg_tweet_length(id)
    length = Tweet.where("twitter_account_id = #{id}").average("character_count").to_f.round(2)

    # ssave length to results table
  end

  def num_followers
    
  end

end