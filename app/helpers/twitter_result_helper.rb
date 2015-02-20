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
  def followers_avg_num_followers(user)
    average = TwitterAccount.find_by(user_id: user.id).followers.average("num_followers").to_f.round(2)
    average
  end

  # Decimal
  def followers_avg_total_tweets(user)
    average = TwitterAccount.find_by(user_id: user.id).followers.average("total_num_tweets").to_f.round(2)
    average
  end

  def char_per_tweet(user)
    char_1_20     = Tweet.where(character_count: 1..20).where(twitter_account_id: user.twitter_account.id).count
    char_21_40    = Tweet.where(character_count: 21..40).where(twitter_account_id: user.twitter_account.id).count
    char_41_60    = Tweet.where(character_count: 41..60).where(twitter_account_id: user.twitter_account.id).count
    char_61_80    = Tweet.where(character_count: 61..80).where(twitter_account_id: user.twitter_account.id).count
    char_81_100   = Tweet.where(character_count: 81..100).where(twitter_account_id: user.twitter_account.id).count
    char_101_120  = Tweet.where(character_count: 101..120).where(twitter_account_id: user.twitter_account.id).count
    char_121_140  = Tweet.where(character_count: 121..140).where(twitter_account_id: user.twitter_account.id).count

    char_per_tweet_hsh = {
      char_1_20: char_1_20,
      char_21_40: char_21_40,
      char_41_60: char_41_60,
      char_61_80: char_61_80,
      char_81_100: char_81_100,
      char_101_120: char_101_120,
      char_121_140: char_121_140
    }

    char_per_tweet_hsh
  end # end of char_per_tweet

end # end Module