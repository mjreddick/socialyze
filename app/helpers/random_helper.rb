module RandomHelper

  # REMEMBER TO ADD CHARACTER COUNT (TWEET LENGTH TO TABLE)
  # tweet.character_count = tweet.tweet_text.length (add twice!)
  def avg_tweet_length(twitter_account_id)
    length = Tweet.where("twitter_account_id = #{twitter_account_id}").average("character_count").to_f.round(2)

    # ssave length to results table
  end

  # Calculate whether a user is an early bird or a night owl tweeter.
  # Early tweets are tweets that were sent between 0600 and 1800 in military time.
  def calculate_early_bird(user, twitter_account_id)
# Currently using user object. If this fails, switch to using id, and change code accordingly
# Error check.  does user have a twitter_result table?

    # Count total number of user's tweets
    total_tweets = Tweet.where(twitter_account_id: twitter_account_id).count

    # If user has no tweets
    if total_tweets == 0
      user.twitter_result.early_bird = nil;
      user.twitter_result.save!
      return
    end

    # Count number of early tweets
    total_early_tweets = Tweet.where(hour: 6..18).where(twitter_account_id: twitter_account_id).count

    # If user has no early tweets, then the early_bird is false
    if total_early_tweets == 0
      user.twitter_result.early_bird = false
      user.twitter_result.save!
      return
    end

    # Percentage of total tweets that were early tweets
    percentage = (total_early_tweets.to_f) / (total_tweets.to_f) * 100

    # Add result to twitter_result table
    if 50 <= percentage
      user.twitter_result.early_bird = true;
    else
      user.twitter_result.early_bird = false;
    end

    user.twitter_result.save!
  end # end of calculate_early_bird


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

end # end of module