module TwitterResultHelper

  # Get user's number of followers
  def num_followers(user)
    total_followers = TwitterAccount.find_by(user_id: user.id).num_followers
    total_followers
  end

  # Get user's total number of tweets
  def total_tweets(user)
    total_tweets = TwitterAccount.find_by(user_id: user.id).total_num_tweets
    total_tweets
  end

  # Characters per Tweet broken into hash for Pie Chart
  def char_per_tweet(user)
    all_tweets = TwitterAccount.find_by(user_id: user.id).tweets
  end

  # Decimal
  def followers_avg_num_followers

  end

  # Decimal
  def followers_avg_total_tweets

  end

end # end Module