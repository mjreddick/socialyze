module TwitterResultHelper
  # Functions to do the twitter analysis to be put into the twitter_results table

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

  def avg_tweet_length(user)
    user.twitter_account.tweets.average("character_count").to_f.round(2)
  end

  def calculate_early_bird(user)
    # Count total number of user's tweets
    total_tweets = user.twitter_account.tweets.count

    return nil if total_tweets.zero?

    total_early_tweets = user.twitter_account.tweets.where(hour: 6..18).count

    # Percentage of total tweets that were early tweets
    percentage = (total_early_tweets.to_f) / (total_tweets.to_f) * 100

    # user.twitter_result.save!
    percentage >= 50
  end # end of calculate_early_bird

  # Get top 10 most used words by the current user
  # Returns a hash where the key is a word and the value is the number of times that word is used
  def get_users_most_used_words(user)
    word_hash = TweetWord.where(twitter_account_id: user.twitter_account.id).group("word").order("count_word DESC").limit(10).count("word")
    hash_to_word_hash_array(word_hash)
  end

  # Get the 10 least used words by the current user
  # Returns a hash where the key is a word and the value is the number of times that word is used
  def get_users_least_used_words(user)
    word_hash = TweetWord.where(twitter_account_id: user.twitter_account.id).group("word").order("count_word ASC").limit(10).count("word")
    hash_to_word_hash_array(word_hash)
  end

  def get_followers_avg_tweet_length(user)
    Tweet.joins("INNER JOIN twitter_follower_relationships ON tweets.twitter_account_id = twitter_follower_relationships.follower_id AND twitter_follower_relationships.followee_id = #{user.twitter_account.id}").average("character_count").to_f.round(2)
  end

  def get_followers_most_used_words(user)
    word_hash = TweetWord.joins("INNER JOIN twitter_follower_relationships ON tweet_words.twitter_account_id = twitter_follower_relationships.follower_id AND twitter_follower_relationships.followee_id = #{user.twitter_account.id}").group("word").order("count_word DESC").limit(10).count("word")
    hash_to_word_hash_array(word_hash)
  end

  def get_followers_least_used_words(user)
    word_hash = TweetWord.joins("INNER JOIN twitter_follower_relationships ON tweet_words.twitter_account_id = twitter_follower_relationships.follower_id AND twitter_follower_relationships.followee_id = #{user.twitter_account.id}").group("word").order("count_word ASC").limit(10).count("word")
    hash_to_word_hash_array(word_hash)
  end

  def hash_to_word_hash_array(hash)
    # Convert {"apple" => 5, "bear" => 3}
    # To [{word: "apple", value: 5}, {word: "bear", value: 3}]
    result = []
    hash.each do |key, value|
      result << {word: key, value: value}
    end
    result
  end

end # end Module