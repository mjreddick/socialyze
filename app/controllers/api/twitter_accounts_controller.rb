module API
  class TwitterAccountsController < ApplicationController

    def index
      render json: TwitterAccount.all
    end

    def create
      twitteraccount = TwitterAccounts.new(twitter_params)
      twitteraccount.save
      render json: twitteraccount, status: 201

    end

    private

    def twitter_params
      params.require(:twitter_account).permit(:twitter_id, :user_id, :token, :secret)
    end

  end
end
