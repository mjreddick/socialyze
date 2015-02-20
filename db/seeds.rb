Tweet.destroy_all
TwitterAccount.destroy_all
User.destroy_all
TweetWord.destroy_all
TwitterFollowerRelationship.destroy_all

APIKey.create!([
  {access_token: "9e409d4b42e7ab24035d7a819759a6c2", user_id: 1},
  {access_token: "644c59391adfffcfa1999e3b7a6ea07d", user_id: 1}
])
Tweet.create!([
  {tweet_text: "lajsdf o aoioaije aijpao", twitter_account_id: 1, twitter_tweet_id: "138032", word_count: nil, character_count: 1, hour: 2},
  {tweet_text: "lkj ", twitter_account_id: 1, twitter_tweet_id: "6289741", word_count: nil, character_count: 140, hour: 6},
  {tweet_text: ";laksjdf lkajs ;fla sf", twitter_account_id: 1, twitter_tweet_id: "8743930", word_count: nil, character_count: 3, hour: 0},
  {tweet_text: "lajsdf o aoioaije aijpao", twitter_account_id: 1, twitter_tweet_id: "19848032", word_count: nil, character_count: 167, hour: 2},
  {tweet_text: "lkj ", twitter_account_id: 1, twitter_tweet_id: "6741", word_count: nil, character_count: 44, hour: 6},
  {tweet_text: ";laksjdf lkajs ;fla sf", twitter_account_id: 1, twitter_tweet_id: "87930", word_count: nil, character_count: 25, hour: 0}
])
TwitterAccount.create!([
  {twitter_uid: "12341", user_id: 1, token: nil, secret: nil, username: nil, time_zone: nil, num_followers: nil, total_num_tweets: nil}
])
TwitterResult.create!([
  {most_used_words: nil, least_used_words: nil, early_bird: false, avg_tweet_length: nil, num_followers: nil, total_tweets: nil, followers_most_used_words: nil, followers_least_used_words: nil, followers_early_bird: nil, followers_avg_tweet_length: nil, followers_avg_num_followers: nil, followers_avg_total_tweets: nil, char_per_tweet: nil, user_id: 1},
  {most_used_words: nil, least_used_words: nil, early_bird: nil, avg_tweet_length: nil, num_followers: nil, total_tweets: nil, followers_most_used_words: nil, followers_least_used_words: nil, followers_early_bird: nil, followers_avg_tweet_length: nil, followers_avg_num_followers: nil, followers_avg_total_tweets: nil, char_per_tweet: "{\"char_1_20\":2,\"char_21_40\":1,\"char_41_60\":1,\"char_61_80\":0,\"char_81_100\":0,\"char_101_120\":0,\"char_121_140\":1}", user_id: nil}
])
User.create!([
  {email: "asdf@asdf.com", password_digest: "$2a$10$DsOdduaGBtsryj53sC6xWe6slJ.yTWDegsA0yANBjexVok6iVGcAe", name: "Asdf"}
])