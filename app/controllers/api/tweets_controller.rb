module API
  class TweetsController < ApplicationController
    def index 
      render json: Tweet.all
    end

    def create
      tweet = Tweet.new(tweet_params)
      tweet.save
      render json: tweet, status: 201
    end

    private

    def tweet_params
      params.require(:tweet).permit(:tweet_text, :twitter_account)
    end
  end
end