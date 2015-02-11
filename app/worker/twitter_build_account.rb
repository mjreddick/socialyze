class TwitterBuildAccount
  include Sidekiq::Worker
  include TwitterHelper

  def perform(info_hash)

    # code to save to twitter_account table

  end
end