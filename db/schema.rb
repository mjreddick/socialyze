# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150219175514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "stop_words", force: true do |t|
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stop_words", ["word"], name: "index_stop_words_on_word", using: :btree

  create_table "tweet_words", force: true do |t|
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "twitter_account_id"
  end

  add_index "tweet_words", ["twitter_account_id"], name: "index_tweet_words_on_twitter_account_id", using: :btree

  create_table "tweets", force: true do |t|
    t.string   "tweet_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "twitter_account_id"
    t.string   "twitter_tweet_id"
    t.integer  "word_count"
    t.integer  "character_count"
    t.integer  "hour"
  end

  add_index "tweets", ["twitter_account_id"], name: "index_tweets_on_twitter_account_id", using: :btree

  create_table "twitter_accounts", force: true do |t|
    t.string   "twitter_uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "time_zone"
    t.integer  "num_followers"
    t.integer  "total_num_tweets"
  end

  add_index "twitter_accounts", ["user_id"], name: "index_twitter_accounts_on_user_id", using: :btree

  create_table "twitter_follower_relationships", force: true do |t|
    t.integer  "followee_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_follower_relationships", ["followee_id"], name: "index_twitter_follower_relationships_on_followee_id", using: :btree
  add_index "twitter_follower_relationships", ["follower_id"], name: "index_twitter_follower_relationships_on_follower_id", using: :btree

  create_table "twitter_results", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "most_used_words"
    t.text     "least_used_words"
    t.boolean  "early_bird"
    t.decimal  "avg_tweet_length"
    t.integer  "num_followers"
    t.integer  "total_tweets"
    t.text     "followers_most_used_words"
    t.text     "followers_least_used_words"
    t.boolean  "followers_early_bird"
    t.decimal  "followers_avg_tweet_length"
    t.decimal  "followers_avg_num_followers"
    t.decimal  "followers_avg_total_tweets"
    t.text     "char_per_tweet"
    t.integer  "user_id"
  end

  add_index "twitter_results", ["user_id"], name: "index_twitter_results_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end
